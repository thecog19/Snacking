#class that gathers data from the snack API
class SnackData
  #client gets passed in so we can more easally stub
  #method simply gets all the snacks and returns those with "optional: false"
  def self.permanent_snacks(client=SnackAPI.new)
    snack_array = client.get_snacks
    mandatory_array = [] 
    snack_array.each do |snack|
      if !snack["optional"]
        mandatory_array << snack
      end
    end
    mandatory_array
  end 
end