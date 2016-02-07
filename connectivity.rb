# From unionFindAlgorithms.rb
	
	# Find the parent of an element
	def quickUnionRoot(idTag, p)
		depth = 0 # Steps removed from the parent
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
			# puts "Parent of #{p} has #{treeSize[quickUnionRoot(idTag, p)[0]]} elements"
			# puts "Parent of #{q} has #{treeSize[quickUnionRoot(idTag, q)[0]]} elements"
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
	end

