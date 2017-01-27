class Algorithm

  def self.minimum_tree(edges)
    sorted_edges = sort_edges(edges)
    sorted_edges.reduce([]) do |forests, edge|
      if edge_exists_in_n_forest(forests, edge) == 1
        joined_forest = update_forest_with_edge(forests, edge)
        forests << joined_forest
      elsif edge_exists_in_n_forest(forests, edge) == 2
        joined_forests = join_forests(forests, edge)
        forests << joined_forests
      else
        forest = [edge]
        forests << forest
      end
    end.flatten(1)
  end

  private

  def self.sort_edges(edges)
    edges.sort_by {|edge, weight| weight }.map { |edge, weight| edge }
  end

  def self.creates_loop?(forest, edge)
    forest.flatten.uniq.include?(edge.first) && forest.flatten.uniq.include?(edge.last)
  end

  def self.edge_exists_in_n_forest(forests, edge)
    forests.select do |forest|
        edge_exists_in_forest?(forest, edge)
      end.count
  end

  def self.edge_exists_in_forest?(forest, edge)
    forest.flatten.include?(edge.first) || forest.include?(edge.last)
  end

  def self.update_forest_with_edge(forests, edge)
    forests.reduce([]) do |new_forest, forest|
      if edge_exists_in_forest?(forest, edge) && !creates_loop?(forest, edge)
        new_forest << forest << edge
      else
        new_forest
      end
    end
  end

  def self.join_forests(forests, edge)
    forests.reduce([]) do |new_forest, forest|
      if edge_exists_in_forest?(forest, edge)
        new_forest << forest << edge
      else
        new_forest
      end
    end.flatten(1)
  end
end
