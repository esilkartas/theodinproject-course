module Enumerable
	def my_each
		for item in self
			yield(item)
		end
		self
	end

	def my_each_with_index
		i = 0
		while i < self.size
			yield(self[i], i)
			i += 1
		end
		self
	end

	def my_select
		new_arr = []
		for item in self
			new_arr << item if yield(item)
		end
		new_arr
	end

	def my_all?
		for item in self
			return false unless yield(item)
		end
		true
	end

	def my_any?
		for item in self
			return true if yield(item)
		end
		false
	end

	def my_none?
		for item in self
			return false if yield(item)
		end
		true
	end

	def my_count
		i = 0
		for item in self
			i += 1
		end
		i
	end

	def my_map
		new_arr = []
		for item in self
			new_arr << yield(item)
		end
		new_arr
	end

	def my_inject(var)
		for item in self
			var = yield(var, item)
		end
		var
	end
end

p [1, 2, 3, 4].my_inject(0) { |masta, i| masta += i }