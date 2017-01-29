class Kruskal

  def self.minimum_spanning_tree(edges)
    sorted_edges = sort_edges(edges)
    sorted_edges.reduce([]) do |forest, edge|
      case edge_belongs_to_n_trees(forest, edge)
        when 1
          update_tree_with_edge(forest, edge)
        when 2
          join_trees_with_edge(forest, edge)
        else
          tree = [edge]
          forest << tree
      end
    end.flatten(1)
  end

  # private

  def self.sort_edges(edges)
    edges.sort_by { |edge, weight| weight }.map { |edge, weight| edge }
  end

  def self.creates_loop?(tree, edge)
    tree.flatten.uniq.include?(edge.first) && tree.flatten.uniq.include?(edge.last)
  end

  def self.edge_belongs_to_n_trees(forest, edge)
   forest.count do |tree|
     edge_exists_in_tree?(tree, edge)
   end
  end

  def self.edge_exists_in_tree?(tree, edge)
    tree.flatten.include?(edge.first) || tree.flatten.include?(edge.last)
  end

  def self.update_tree_with_edge(forest, edge)
    forest.map do |tree|
      if edge_exists_in_tree?(tree, edge) && !creates_loop?(tree, edge)
        tree << edge
      else
        tree
      end
    end
  end

  def self.join_trees_with_edge(forest, edge)
   forest_without_trees_to_join = forest.reject { |tree| edge_exists_in_tree?(tree, edge) }
   forest_with_trees_to_join = forest.select { |tree| edge_exists_in_tree?(tree, edge) }
   forest_without_trees_to_join + [(forest_with_trees_to_join[0] + forest_with_trees_to_join[1] + [edge])]
  end

  def self.duplicate_edge?(tree, new_edge)
    tree.any? { |existing_edge| p existing_edge; p new_edge; p "x"; existing_edge.sort == new_edge.sort}
  end
end
