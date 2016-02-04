someArray = []

('a'..'j').each do |i| someArray << i end

p someArray
puts "----------"

idTag = []
treeSize = []

(0...(someArray.size)).each do |i| idTag << i end
(0...(someArray.size)).each do |i| treeSize << 1 end
 p idTag
 p treeSize

# Quick Find
quickFind = Proc.new do
	######################################
	# quickFindUnite operation - slowest method:
	# To connect p and q, set id of p = q
	def quickFindUnite(idTag, p, q)
		id_p = idTag[p]
		(0...(idTag.size)).each do |i| 
			if (idTag[i] == id_p) 
				idTag[i] = idTag[q]
			end
		end
		return idTag
	end

	# Testing quickFindUnite
	testingquickFindUnite = Proc.new do
		idTag = quickFindUnite(idTag, 0, 5)
		p idTag
		idTag = quickFindUnite(idTag, 1, 2)
		p idTag
		idTag = quickFindUnite(idTag, 2, 7)
		p idTag
		idTag = quickFindUnite(idTag, 3, 8)
		p idTag
		idTag = quickFindUnite(idTag, 4, 9)
		p idTag
		idTag = quickFindUnite(idTag, 5, 6)
		p idTag
		idTag = quickFindUnite(idTag, 6, 7)
		p idTag
		idTag = quickFindUnite(idTag, 8, 9)
		p idTag

		(0..4).each {|i| print "#{idTag[i]}  "}
		print "\n"
		(5..9).each {|i| print "#{idTag[i]}  "}
		print "\n"
	end

	testingquickFindUnite.call

	# Connectivity tested with quickFindUnite
	def isConnected(idTag, p, q)
		if (p < idTag.size && q < idTag.size)
			return (idTag[p] == idTag[q])
		else
			puts "Out of range"
			return 1
		end
	end

	quickFind_isConnected = Proc.new do |p,q|
		print "Is #{p} connected to #{q}? "  
			if (isConnected(idTag,p , q))
				print "YES!"
			else
				print "Nope!"
			end
		print "\n"
	end	

	quickFind_isConnected.call(0,6)
end
# quickFind.call


# Quick Union
quickUnion = Proc.new do
	# quickUnionUnite - still slow
	# To unite p and q, set the id of q's root to p's root
	# Define root: i == id[i]

	#idTag = [1,1,2,3,3,4,4,6,3,9]
	def quickUnionRoot(idTag, p)
		depth = 0
		while (p != idTag[p])
			p = idTag[p]
			depth += 1
		end
		return p, depth
	end

	echoRoot = Proc.new do |val|
		print "The root of #{val} is ", quickUnionRoot(idTag, val)[0], "\n"
		print "The depth of the branch is: ",
			quickUnionRoot(idTag, val)[1], "\n"
	end

	def isConnectedQU(idTag, p, q)
		return quickUnionRoot(idTag, p)[0] == quickUnionRoot(idTag, q)[0]
	end

	quickUnion_isConnected = Proc.new do |p,q|
			print "Is #{p} connected to #{q}? "  
				if (isConnectedQU(idTag, p, q))
					print "YES!"
				else
					print "Nope!"
				end
			print "\n"
	end	


	def quickUnionUnite(idTag, p, q)
		idTag[p] = quickUnionRoot(idTag, q)[0]
		return idTag
	end

	testingQuickUnionUnite = Proc.new do
		idTag = quickUnionUnite(idTag, 0, 1)
		p idTag
		idTag = quickUnionUnite(idTag, 5, 4)
		p idTag
		idTag = quickUnionUnite(idTag, 7, 6)
		p idTag
		idTag = quickUnionUnite(idTag, 6, 4)
		p idTag
		idTag = quickUnionUnite(idTag, 4, 3)
		p idTag
		idTag = quickUnionUnite(idTag, 8, 3)
		p idTag
	end

	testingQuickUnionUnite.call
	echoRoot.call(7)
	quickUnion_isConnected.call(5,7)
end
# quickUnion.call

# Weighted Quick Union
weightedQuickUnion = Proc.new do
	# To unite p and q, set the id of q's root to p's root
	# BUT this time check to see which branch is longer
	# Define root: i == id[i]

	# idTag = [1,1,2,3,3,4,4,6,3,9]


	def quickUnionRoot(idTag, p)
		depth = 0
		while (p != idTag[p])
			p = idTag[p]
			depth += 1
		end
		return p, depth
	end

	echoRoot = Proc.new do |val|
		print "The root of #{val} is ", quickUnionRoot(idTag, val)[0], "\n"
		print "The depth of the branch is: ",
			quickUnionRoot(idTag, val)[1], "\n"
	end

	def isConnectedQU(idTag, p, q)
		return quickUnionRoot(idTag, p)[0] == quickUnionRoot(idTag, q)[0]
	end

	quickUnion_isConnected = Proc.new do |p,q|
			print "Is #{p} connected to #{q}? "  
				if (isConnectedQU(idTag, p, q))
					print "YES!"
				else
					print "Nope!"
				end
			print "\n"
	end	

	


	def quickUnionUnite(idTag, treeSize, p, q)
		# CAUTION:
		# This function will alter the global arrays idTag and treeSize
		# Check to see if p,q are already connected
		if (quickUnionRoot(idTag, p)[0] != quickUnionRoot(idTag,q)[0])
			puts "Parent of #{p} has #{treeSize[quickUnionRoot(idTag, p)[0]]} elements"
			puts "Parent of #{q} has #{treeSize[quickUnionRoot(idTag, q)[0]]} elements"
			# Compare the size of elements attached to the parent of p and q
			if treeSize[quickUnionRoot(idTag, p)[0]] <= treeSize[quickUnionRoot(idTag, q)[0]]
				# Add elements in parent of p to parent of q
				treeSize[quickUnionRoot(idTag, q)[0]] += treeSize[quickUnionRoot(idTag, p)[0]]
				# p's parent attached under q's parent
				idTag[quickUnionRoot(idTag, p)[0]] = quickUnionRoot(idTag, q)[0]
				# NOTE: The order matter, calculate branch size to be added before connecting the smaller branch to the larger
			else
				# Add elements in parent of q to parent of p
				treeSize[quickUnionRoot(idTag, p)[0]] += treeSize[quickUnionRoot(idTag, q)[0]]
				# q's parent attached under p's parent
				idTag[quickUnionRoot(idTag, q)[0]] = quickUnionRoot(idTag, p)[0]
			end
		end
		return treeSize
	end

	

	testingQuickUnionUnite = Proc.new do
		quickUnionUnite(idTag, treeSize, 0, 1)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 5, 4)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 7, 6)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 6, 4)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 4, 3)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 8, 3)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 7, 0)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 2, 9)
		p idTag
		p treeSize
		quickUnionUnite(idTag, treeSize, 4, 2)
		p idTag
		p treeSize
	end

	testingQuickUnionUnite.call
	echoRoot.call(4)
	quickUnion_isConnected.call(2,7)
end

# weightedQuickUnion.call


# Set the parent of the shorter data tree to the longer one
# U(p,q) => id_p == id[q] 
