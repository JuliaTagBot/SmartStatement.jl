
using FriendlyDoLoop: CellPointToValueFromRefValues

let

  v1 = rand(4)
  v2 = rand(3)
  v3 = rand(5)
  
  ref_to_value = [ v1, v2, v3  ]
  
  cell_to_ref = rand(1:3,10000)
  
  cell_to_values = CellPointToValueFromRefValues{Scal}(
    ref_to_value,cell_to_ref)

  @test isa(cell_to_values,CellPointToValue)
  
  @time begin
    passed = true
    arr = Float64[]
    for cell in 1:ncells(cell_to_values)
  
      val1 = getvalues(cell_to_values,cell,arr)
      val2 = ref_to_value[cell_to_ref[cell]]

      for point in 1:npoints(cell_to_values,cell)

        passed = passed && (val1[point] == val2[point])

      end
    end
  end
  @test passed

end
