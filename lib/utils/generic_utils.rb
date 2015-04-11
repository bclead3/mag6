require 'bigdecimal/math'

module Utils
    class GenericUtils
        START_ROW = 1

        def self.get_sheet(filename, sheet_number = 1, library = 'SimpleXlsxReader')
            sheet = nil
            if library == 'SimpleXlsxReader'
                doc = SimpleXlsxReader.open(filename)
                sheet = doc.sheets[sheet_number-1]
            else
                clazz = library.constantize
                doc = clazz.new(filename)
                if sheet_number == 1
                    sheet = doc.sheet(0)
                else
                    sheet = doc.sheet(sheet_number-1)
                end
            end
            sheet
        end

        def self.get_numeric_formats
            format_array = @formats
            if format_array.nil? ||format_array.empty?
                @formats = []
                @formats.push([ 0x00, 1234.567,   0,         'General' ])
                @formats.push([ 0x01, 1234.567,   0,         '0' ])
                @formats.push([ 0x02, 1234.567,   0,         '0.00' ])
                @formats.push([ 0x03, 1234.567,   0,         '#,##0' ])
                @formats.push([ 0x04, 1234.567,   0,         '#,##0.00' ])
                @formats.push([ 0x05, 1234.567,   -1234.567, '($#,##0_);($#,##0)' ])
                @formats.push([ 0x06, 1234.567,   -1234.567, '($#,##0_);[Red]($#,##0)' ])
                @formats.push([ 0x07, 1234.567,   -1234.567, '($#,##0.00_);($#,##0.00)' ])
                @formats.push([ 0x08, 1234.567,   -1234.567, '($#,##0.00_);[Red]($#,##0.00)' ])
                @formats.push([ 0x09, 0.567,      0,         '0%' ])
                @formats.push([ 0x0a, 0.567,      0,         '0.00%' ])
                @formats.push([ 0x0b, 1234.567,   0,         '0.00E+00' ])
                @formats.push([ 0x0c, 0.75,       0,         '# ?/?' ])
                @formats.push([ 0x0d, 0.3125,     0,         '# ??/??' ])
                @formats.push([ 0x0e, 36892.521,  0,         'm/d/yy' ])
                @formats.push([ 0x0f, 36892.521,  0,         'd-mmm-yy' ])
                @formats.push([ 0x10, 36892.521,  0,         'd-mmm' ])
                @formats.push([ 0x11, 36892.521,  0,         'mmm-yy' ])
                @formats.push([ 0x12, 36892.521,  0,         'h:mm AM/PM' ])
                @formats.push([ 0x13, 36892.521,  0,         'h:mm:ss AM/PM' ])
                @formats.push([ 0x14, 36892.521,  0,         'h:mm' ])
                @formats.push([ 0x15, 36892.521,  0,         'h:mm:ss' ])
                @formats.push([ 0x16, 36892.521,  0,         'm/d/yy h:mm' ])
                @formats.push([ 0x25, 1234.567,   -1234.567, '(#,##0_);(#,##0)' ])
                @formats.push([ 0x26, 1234.567,   -1234.567, '(#,##0_);[Red](#,##0)' ])
                @formats.push([ 0x27, 1234.567,   -1234.567, '(#,##0.00_);(#,##0.00)' ])
                @formats.push([ 0x28, 1234.567,   -1234.567, '(#,##0.00_);[Red](#,##0.00)' ])
                @formats.push([ 0x29, 1234.567,   -1234.567, '_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)' ])
                @formats.push([ 0x2a, 1234.567,   -1234.567, '_($* #,##0_);_($* (#,##0);_($* "-"_);_(@_)' ])
                @formats.push([ 0x2b, 1234.567,   -1234.567, '_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)' ])
                @formats.push([ 0x2c, 1234.567,   -1234.567, '_($* #,##0.00_);_($* (#,##0.00);_($* "-"??_);_(@_)' ])
                @formats.push([ 0x2d, 36892.521,  0,         'mm:ss' ])
                @formats.push([ 0x2e, 3.0153,     0,         '[h]:mm:ss' ])
                @formats.push([ 0x2f, 36892.521,  0,         'mm:ss.0' ])
                @formats.push([ 0x30, 1234.567,   0,         '##0.0E+0' ])
                @formats.push([ 0x31, 1234.567,   0,         '@' ])
            end
            @formats
        end

        def self.excel_numeric_formats(workbook)
            center  = workbook.add_format(:align => 'center')
            heading = workbook.add_format(:align => 'center', :bold => 1)
            worksheet = workbook.add_worksheet('Numeric formats')

            worksheet.set_column(0, 4, 15)
            worksheet.set_column(5, 5, 45)

            worksheet.write(0, 0, "Index",       heading)
            worksheet.write(0, 1, "Index",       heading)
            worksheet.write(0, 2, "Unformatted", heading)
            worksheet.write(0, 3, "Formatted",   heading)
            worksheet.write(0, 4, "Negative",    heading)
            worksheet.write(0, 5, "Format",      heading)

            formats = get_numeric_formats

            i = 0
            formats.each do |format|
                style = workbook.add_format()
                style.set_num_format(format[0])

                i += 1
                worksheet.write(i, 0, format[0],                    center)
                worksheet.write(i, 1, sprintf("0x%02X", format[0]), center)
                worksheet.write(i, 2, format[1],                    center)
                worksheet.write(i, 3, format[1],                    style)

                if format[2] != 0
                    worksheet.write(i, 4, format[2], style)
                end

                worksheet.write_string(i, 5, format[3])
            end

            workbook
        end

        def self.create_workbook_from_file(filename)
            book = WriteExcel.new(filename)
        end

        def self.scrub(variable, decimal_places)
            return_value = ""
            unless variable.blank?
                temp_value = BigDecimal.new(variable.to_s)
                return_value = temp_value.round(decimal_places, :default).to_s
            end
            return_value
        end

        def self.scrub_date(date_value)
            return_value = nil
            if ! date_value.blank?
                return_value = date_value
            end
            return_value
        end

        def self.scrub_time(time_value)
            return_value = nil
            if !time_value.blank?
                time_only = time_value.to_s.split(' ')[1]
                return_value = time_only #Time.strptime(time_only,'%H:%M:%S')
            end
            return_value
        end

        def self.calculate(sql_string, decimal_places=2)
            return_bd = Loan.find_by_sql(sql_string).first.calc
            if return_bd.nil?
                return_bd = BigDecimal.new('0.0')
            end
            unless decimal_places == 0
                return_bd.round(decimal_places, :default) # http://www.ruby-doc.org/stdlib-1.9.3/libdoc/bigdecimal/rdoc/BigDecimal.html#method-c-mode
            end
        end

        def self.format_percentage_from_two_values(first_value, second_value, round_value=2)
            unless second_value.to_f == 0.0
                unless first_value.nil?
                    unless first_value.to_f == 0.0
                        val1 = BigDecimal.new(first_value.to_s).round(round_value, :default)
                        val2 = BigDecimal.new(second_value.to_f.to_s).round(round_value, :default)
                        return_val = val1.div(val2,round_value+7) * BigDecimal.new('100.0000')
                        sprintf("%.#{round_value}f%", return_val)
                    else
                        return_val = BigDecimal.new(first_value.to_f.to_s).round(round_value, :default)
                        sprintf("%.#{round_value}f%", return_val)
                    end
                else
                    return_val = BigDecimal.new(first_value.to_f.to_s).round(round_value, :default)
                    sprintf("%.#{round_value}f%", return_val)
                end
            else
                "N/A"
            end
        end
    end
end