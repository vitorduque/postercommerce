class Graph
  include ActiveModel::Model

  attr_accessor :begin, :end, :names, :amount

  def mine_order_items(items, orders_id)
    @main_hash ||= Hash.new
    @score = Array.new
    @filter = Array.new
    @sum = Array.new
    @name = Array.new
    sum = 0
    item_array = Array.new
    name = ""

    #Create a hash with arrays of items of the same order
    orders_id.each_with_index do |order_id, index|
    @main_hash.merge!({order_id: order_id})
    @main_hash[order_id] = Hash.new
      items.each_with_index do |item, index|
        if item.orders_id.eql? order_id
          item_array << [item.posters_id, item.size]
          name << "Id: #{item.posters_id} Size: #{item.size}/"
        end
      end
      @main_hash[order_id].merge!({content: item_array, name: name})
      item_array = Array.new
      name = ""
    end

    #Unify the content in hash
    @backup = @main_hash.to_a
    arr = Array.new
    @main_hash.each{|key, val| arr.include?(val) ? @main_hash.delete(key) : arr << val }

    #Filter the combinations
    @main_hash.each do |combination|
      if @main_hash.first.eql? combination
        next
      end
      @filter << combination[1][:content]
    end

    #Count the combinations
    @filter.each_with_index do |wut, index|
      @backup.each do |backup|
        if @backup.first.eql? backup
          next
        end
        if backup[1][:content].eql? wut
          sum = sum + 1
        end
      end
      @sum[index] = sum
      sum = 0
    end

    #Merge de amount to main_hash
    @backup = @main_hash.to_a
    @main_hash.each_with_index do |hash,index|
      if @main_hash.first.eql? hash
        next
      end
      @main_hash[@backup[index][0]].merge!({amount: @sum[index-1]})
    end

    #Fill the array name
    @backup.each_with_index do |hash,index|
      if @backup.first.eql? hash
        next
      end
      @name[index-1] = @backup[index][1][:name]
    end

    #create a unique array to order
    @all = Array.new
    @name.each_with_index do |wtf, index|
      @all[index] = Array.new
      @all[index] <<  wtf
      @all[index] << @sum[index]
    end
    @all.sort! { |a,b| b[1] <=> a[1] }

    #Separate in name array and amount array
    @name = Array.new
    @sum = Array.new
    @all.each_with_index do |all, index|
      @name << all[0]
      @sum <<  all[1]
    end

    @names = @name
    @amount = @sum

  end
end
