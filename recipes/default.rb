#
# Cookbook:: chef_demo_cookbook
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
encryption_file = data_bag_item('encryption', 'keys')['filename']
secret = ::File.read(encryption_file).chomp
info = data_bag_item('ssh_keys', 'user-a', "#{secret}")['_default']['private_key']

file '/tmp/ssh_private_key.txt' do
  content info
end
