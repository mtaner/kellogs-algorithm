require 'kruskal'

RSpec.describe Kruskal, "join_trees_with_edge" do

  it "joins two trees with the edge" do
    tree_one = [[:a, :b], [:b, :f]]
    tree_two = [[:g, :h], [:h, :z]]
    tree_three = [[:z, :j]]
    forest = [tree_one, tree_two, tree_three]
    test_edge = [:a, :h]

    expect(Kruskal.join_trees_with_edge(forest, test_edge).flatten(1))
      .to eq [[[:z, :j]], [[:a, :b], [:b, :f], [:g, :h], [:h, :z], [:a, :h]]].flatten(1)
  end

end

RSpec.describe Kruskal, "update_tree_with_edge" do

  it "adds the edge to whichever tree it belongs to" do
    tree_one = [[:a, :b], [:b, :f]]
    tree_two = [[:g, :h], [:h, :z]]
    forest = [tree_one, tree_two]
    test_edge = [:a, :j]

    expect(Kruskal.update_tree_with_edge(forest, test_edge).flatten(1))
      .to eq [[[:a, :b], [:b, :f], [:a, :j]], tree_two].flatten(1)
  end

  it "does not add the edge if it creates a loop" do
    tree_one = [[:a, :b], [:b, :f]]
    tree_two = [[:g, :h], [:h, :i]]
    forest = [tree_one, tree_two]
    test_edge = [:g, :i]

    expect(Kruskal.update_tree_with_edge(forest, test_edge).flatten(1))
      .to eq forest.flatten(1)
  end

end

RSpec.describe Kruskal, "edge_exists_in_n_trees" do

  it "knows when the edge is not in any of the trees" do
    tree_one = [[:a, :b], [:b, :f]]
    tree_two = [[:g, :h], [:h, :z]]
    forest = [tree_one, tree_two]
    test_edge = [:k, :j]

    expect(Kruskal.edge_belongs_to_n_trees(forest, test_edge)).to be 0
  end

  it "knows when the edge is in one of the trees" do
    tree_one = [[:a, :b], [:b, :f]]
    tree_two = [[:g, :h], [:h, :z]]
    forest = [tree_one, tree_two]
    test_edge = [:k, :a]

    expect(Kruskal.edge_belongs_to_n_trees(forest, test_edge)).to be 1
  end

  it "knows when the edge is in two trees" do
    tree_one = [[:a, :b], [:b, :f]]
    tree_two = [[:g, :h], [:h, :z]]
    forest = [tree_one, tree_two]
    test_edge = [:z, :a]

    expect(Kruskal.edge_belongs_to_n_trees(forest, test_edge)).to be 2
  end

end
