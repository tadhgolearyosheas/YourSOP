class RisksImpact < ActiveRecord::Base

	def desc
		return impact + ": " + description
	end
end
