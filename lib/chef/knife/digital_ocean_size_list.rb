# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require File.expand_path('../digital_ocean_base', __FILE__)

class Chef
  class Knife
    class DigitalOceanSizeList < Knife
      include Knife::DigitalOceanBase

      banner 'knife digital_ocean size list (options)'

      def run
        $stdout.sync = true

        validate!

        size_list = [
          h.color('ID',   :bold),
          h.color('Name', :bold)
        ]

        sizes = client.sizes.list.sizes

        sizes.sort! do |a, b|
          a.name.to_i <=> b.name.to_i
        end

        sizes.each do |size|
          size_list << size.id.to_s
          size_list << size.name.to_s
        end

        puts h.list(size_list, :uneven_columns_across, 2)
      end
    end
  end
end
