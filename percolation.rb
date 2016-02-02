require_relative "make2Dtable"

row = 3
col = 10
someArray = Array.new(row){Array.new(col)}

# Populate array
# ... exclusive, .. inclusive
(0...row).each do |row|
	(0...col).each do |col|
		someArray[row][col] = rand(2)  
	end
end

make2Dtable(someArray)