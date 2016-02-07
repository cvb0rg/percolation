require_relative "make2Dtable"
require_relative "CONNECTIVITY"

row = 10
col = 10
someArray = Array.new(row){Array.new(col)}
idTag = []
idIndex = []
treeSize = []

# Populate array, randomly, 0 = empty, 1 = filled
# ... exclusive, .. inclusive
(0...row).each do |row|
	(0...col).each do |col|
		someArray[row][col] = rand(2)  
	end
end

# Test array
# someArray = [[1, 1, 0, 0, 1, 1, 1, 0, 0, 1], [0, 1, 0, 0, 0, 1, 0, 1, 0, 1], [0, 0, 1, 0, 0, 0, 1, 0, 1, 1]]


(0...(row * col + 2)).each do |i| idIndex << i end
(0...(row * col + 2)).each do |i| idTag << i end
(0...(row * col + 2)).each do |i| treeSize << 1 end

# p idIndex
# p idTag
# p treeSize
make2Dtable(someArray)


# Connect the first and last rows to input and output:
# i.e. all the 0's in the first row are connected together
# and all the 0's in the last row are connected together
(0...col).each do |cell|
	if (someArray[0][cell] == 0)
		idTag[cell] = idTag[row * col]
	end

	if (someArray[row - 1][cell] == 0)
		idTag[(row - 1) * col + cell] = idTag[row * col + 1]
	end
end

(0...row).each do |r|
	(0...col).each do |c|
		index = r * col + c 
		# p index
		if (someArray[r][c] == 0  && someArray[r][c] == someArray[r][c + 1])
		 	quickUnionUnite(idTag, treeSize, index,  index + 1)
		 	# print r,", ", c, "\n"
		end
	end
end

(0...col).each do |c| 
	(0...row).each do |r|
		index = c + r * col
		if r < row - 1
			if (someArray[r][c] == 0  && someArray[r][c] == someArray[r + 1][c])
			 	quickUnionUnite(idTag, treeSize, index,  index + col)
			end
		end
	end
end


connectVerticallyDebug = Proc.new do
	p idTag
	p treeSize
	puts "--"
	make2Dtable(someArray)
	(0...col).each do |c| 
		(0...row).each do |r|
			index = c + r * col
			# p index
			print "index", index, " - ", r,", ", c, " : ", someArray[r][c]
			print " is zero?: ", (someArray[r][c] == 0) #,"\n"
			if r < row - 1
				if (someArray[r][c] == 0  && someArray[r][c] == someArray[r + 1][c])
				 	print " - is joined? ", someArray[r][c] == someArray[(r + 1)][c], "\n"
				 	quickUnionUnite(idTag, treeSize, index,  index + col)
				else
					print "\n"
				end
			else
				print "\n"
			end
		end
	end

	p someArray
	p idIndex
	p idTag
	p treeSize

	make2Dtable(someArray)
end
# connectVerticallyDebug.call

print "Does this table perculate: ", isConnectedQU(idTag, (row * col), (row * col + 1)), "\n"





