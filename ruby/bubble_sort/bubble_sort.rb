def bubble_sort(array)
	loop do
		swapped = false
		(array.length - 1).times do	|i|
			if array[i] > array[i+1]
				array[i], array[i+1] = array[i+1], array[i]
				swapped = true
			end
		end
		break unless swapped
	end
	array
end

def bubble_sort_by(array)
	loop do
		swapped = false
		(array.length - 1).times do	|i|
			if yield(array[i], array[i+1]) > 0
				array[i], array[i+1] = array[i+1], array[i]
				swapped = true
			end
		end
		break unless swapped
	end
	array
end

puts bubble_sort([9,7,5,8,1])
puts bubble_sort_by(["hi","hello","hey"]) { |left, right| left.length - right.length }
