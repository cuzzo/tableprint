require 'tableprint'

t = {}
table.insert(t, {'Helga G. Pataki', 9, 'Queens', '11412'})
table.insert(t, {'Arnold', 9, 'Queens', '11412'})
table.insert(t, {'Harold Berman', 13, 'Queens', '11412'})

table.print(t, {'name', 'age', 'city', 'zip'})
