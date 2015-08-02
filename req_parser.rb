@test = "GET / HTTP/1.1\r\nHost: blah.com\r\n\r\n"

def parser(input)
 posi = 0
 header_collection = {}

 parsed_method = method(posi)
 puts "Method: #{parsed_method[1]}"
 posi = parsed_method[0]

 parsed_url = url(posi)
 puts "URL: #{parsed_url[1]}"
 posi = parsed_url[0]

 parsed_version = version(posi)
 puts "Version: #{parsed_version[1]}"
 posi = parsed_version[0]

 parsed_headers = headers(posi)
 posi = parsed_headers[0]
end


def method(start_posi)
 method, char = ""
 current_posi = start_posi
 while char != " "
  char = @test[current_posi]
  method << char
  current_posi += 1
 end
 return current_posi, method
end

def url(start_posi)
 url, char = ""
 current_posi = start_posi
 while char != " "
  char = @test[current_posi]
  url << char
  current_posi += 1
 end
 return current_posi, url
end

def version(start_posi)
 version, char = ""
 current_posi = start_posi
 while char != "\n"
  char = @test[current_posi]
  version << char
  current_posi += 1
 end
 return current_posi, version
end

def headers(start_posi)
 headers = {}
 char = ""
 current_posi = start_posi

 while !is_line_empty?(current_posi) do
  key = header_key(current_posi)
  current_posi = key[0]
  value = header_value(current_posi)
  current_posi = value[0]
  headers[key[1]] = value[1]
 end
 puts headers
 return current_posi, headers
end


def header_key(start_posi)
 hd_key = ""
 current_posi = start_posi
 char = @test[current_posi]
 while char != ":"
  hd_key << char
  current_posi += 1
  char = @test[current_posi]
 end
 return current_posi + 2, hd_key
end

def header_value(start_posi)
 hd_value, char = ""
 current_posi = start_posi
 char = @test[current_posi]
 while char != "\n"
  hd_value << char
  current_posi += 1
  char = @test[current_posi]
 end
 return current_posi + 1, hd_value[0...-1]
end

def is_line_empty?(start_posi)
 current_posi = start_posi

 if @test[current_posi] == "\r" && @test[current_posi+1] == "\n"
   true
 else
   false
 end
end

puts @test
parser(@test)
