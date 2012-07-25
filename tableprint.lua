--- tableprint.lua
-- @author Cuzzo Yahn
-- @copyright 2012.07.25
-- @license BSD-2-Clause (liscense.txt)

--- Prints a table in sql-style format.
-- 
--  EG: t = {}
--      row_1 = {'row_1:column_1', 'row_1:column_2', 'row_1:column_3'}
--      row_2 = {'row_2:column_1', 'row_2:column_2', 'row_2:column_3'}
--      caption_table = {'column_1', 'column_2', 'column_3'}
--
--      table.insert(t, row_1)
--      table.insert(t, row_2)
--
--      table.print(t, caption_table)
--
--  OP:
--      +----------------+----------------+----------------+
--      | column_1       | column_2       | column_3       |
--      +----------------+----------------+----------------+
--      | row_1:column_1 | row_1:column_2 | row_1:column_3 |
--      | row_2:column_1 | row_2:column_2 | row_2:column_3 |
--      +----------------+----------------+----------------+
--  
-- @param t (Table)
--   A table / list of similar rows.
-- @param caption_table (Table)
--   A table / row of captions to identify the columns of the table.
--
-- @return (nil)
--   Prints a sql-style table to the console.
function table.print(t, caption_table)
    local col_widths = _tp_col_widths(t, caption_table)
    local divider = _tp_get_divider(col_widths)

    print(divider)
    _tp_print_row(caption_table, col_widths)
    print(divider)

    for _,r in pairs(t) do
        _tp_print_row(r, col_widths)
    end
    print(divider)
end

--- Prints a row of a table.
-- 
-- @param row (Table)
--   A table / list of fields.
-- @param col_widths (Table)
--   A table / list of widths for each column of the table.
--
-- @return (nil)
--   Prints a sql-style row to the console.
function _tp_print_row(row, col_widths)
    local row_str = '|'

    for i,v in ipairs(row) do
        row_format_str = string.format('%s %%-%ds |', row_str, col_widths[i])
        row_str = string.format(row_format_str, tostring(v))
    end

    print(row_str)
end

--- Builds a formatted divider to separate the table header and body.
--
-- @param col_widths (Table)
--   A table / list of widths for each column of the table.
--
-- @return (str)
--   A divider string.
function _tp_get_divider(col_widths)
    local div_str = ''
    for _,col_width in pairs(col_widths) do
        div_str = div_str .. '+-'
        for i = 1, col_width do
            div_str = div_str .. '-'
        end
        div_str = div_str .. '-'
    end
    div_str = div_str .. '+'
    return div_str
end

--- Calculates the width of each column of the table.
--
-- @param t (Table)
--   A table / list of similar rows.
-- @param caption_table (Table)
--   A table / row of captions to identify the columns of the table.
--
-- @return (Table)
--   A table / list of the widths of each column.
function _tp_col_widths(t, caption_table)
    if #t == 0 then
        return nil
    end

    local col_count = #t[1]
    local col_widths = {}
    for i = 1, col_count do
        col_widths[i] = 0
    end

    for _,r in pairs(t) do
        for i = 1, #r do
            local cell_width = tostring(r[i]):len()
            if col_widths[i] < cell_width then
                col_widths[i] = cell_width
            end
        end
    end

    for i = 1, #col_widths do
        caption_width = tostring(caption_table[i]):len()
        if caption_width > col_widths[i] then
            col_widths[i] = caption_width
        end
    end

    return col_widths
end

