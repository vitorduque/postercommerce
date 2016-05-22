class Graph
  include ActiveModel::Model

  attr_accessor :begin, :end, :names, :amount, :male, :female, :count, :order_date, :max, :category, :category_score, :graph_3_names, :graph_3_scores


  def datas_graph_three(something)
    @graph_3_names = Array.new
    @graph_3_scores = Array.new

    something.each_with_index do |s, index|
      @graph_3_names[index] = Array.new
      @graph_3_scores[index] = Array.new
      s.each do |ss|
        @graph_3_names[index] << ss.category
        @graph_3_scores[index] << ss.category_score
      end
    end
    binding.pry
  end

  def graph_category_sex(male, female)
    @male = Array.new(12,0)
    @female = Array.new(12,0)
    @max = 0


    male.each do |m|

      if m.count > @max
        @max = m.count
      end
      m.order_date.delete! '0'
      @male[(m.order_date.to_i) - 1] = m.count
    end

    female.each do |f|
      if f.count > @max
        @max = f.count
      end
      f.order_date.delete! '0'
      @female[(f.order_date.to_i) - 1] = f.count
    end

  end



  def mine_order_items(items, orders_id)
    main_hash ||= Hash.new
    score = Array.new
    filter_hash = Array.new
    @sum = Array.new
    @name = Array.new
    sum = 0
    item_array = Array.new
    name = ""

    #Create a hash with arrays of items of the same order
    orders_id.each_with_index do |order_id, index|
    main_hash.merge!({order_id: order_id})
    main_hash[order_id] = Hash.new
      items.each_with_index do |item, index|
        if item.orders_id.eql? order_id
          item_array << [item.posters_id, item.size]
          name << "Id: #{item.posters_id} Size: #{item.size}/"
        end
      end
      main_hash[order_id].merge!({content: item_array, name: name})
      item_array = Array.new
      name = ""
    end

    #Unify the content in hash
    @backup = main_hash.to_a
    arr = Array.new
    main_hash.each{|key, val| arr.include?(val) ? main_hash.delete(key) : arr << val }

    #Filter the combinations
    main_hash.each do |combination|
      if main_hash.first.eql? combination
        next
      end
      filter_hash << combination[1][:content]
    end

    #Count the combinations
    filter_hash.each_with_index do |wut, index|
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
    @backup = main_hash.to_a
    main_hash.each_with_index do |hash,index|
      if main_hash.first.eql? hash
        next
      end
      main_hash[@backup[index][0]].merge!({amount: @sum[index-1]})
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
