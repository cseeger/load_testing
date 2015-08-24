require 'rubygems'
require 'ruby-jmeter'

HOST_NAME = ENV['HOST_NAME'] ? ENV['HOST_NAME'] : 'https://www.some_fashion_site.com'

test do
  threads count: 5, duration: 60 do
    # use cookies
    cookies policy: 'default', clear_each_iteration: true
    cache clear_each_iteration: true

    transaction 'Load Categories' do
      visit name: 'Mens', url: HOST_NAME + '/mens' do
        assert 'contains' => 'Green Watch Cap'
      end
      visit name: 'Womens', url: HOST_NAME + '/womens' do
        assert 'contains' => 'Back Zip Ankle '
      end
    end

    view_results_in_table
    view_results_tree
    graph_results
    aggregate_graph
  end
end.jmx
