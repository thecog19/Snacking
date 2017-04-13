#class that gathers data from the snack API
class SnackData
  def self.permanent_snacks
    snack_array = SnackAPI.new.get_snacks
    mandatory_array = []
    snack_array.each do |snack|
      if !snack["optional"]
        mandatory_array << snack
      end
    end
    mandatory_array
  end 
end