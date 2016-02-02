# 2D representation of a 2D grid mesh

def make2Dtable(someArray)
	
	horLine = Proc.new {
		(someArray[1].size + (someArray[1].size + 1) ).times { print '-'}
	print "\n"
	}

	someArray.each do |x|
		horLine.call
		x.each do |cell|
			print "|#{cell}"
		end
		print "|\n"
	end
	horLine.call
end



# Testing:

# someArray = [[1,2,3,0],[4,5,6,0],[7,8,9,0]]
# make2Dtable(someArray)