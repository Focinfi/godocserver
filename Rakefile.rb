require 'open3'

task default: :hello

desc "Say hello"
task :hello  do
  puts all_go_builtin_pkgs "ENV['GOROOT']"
end

def all_go_builtin_pkgs go_root_src_path
  Dir.glob("#{go_root_src_path}**/*/").map { |pkg| pkg[go_root_src_path.length...-1] }.select { |pkg| !pkg.match(/builtin|cmd|go|debug|vendor|testdata/) }.to_a
end


def pkg_path_of(pkg)
  "#{Dir.pwd}/public/pkg/#{pkg}.html"
end

def generate(pkg)
  # run shell script
  _, stdout, _ = Open3.popen3("godoc -html #{pkg}") 

  dirs = pkg.split("/")
  if dirs.length > 1
    _, _, stderr = Open3.popen3("mkdir -p #{Dir.pwd}/public/pkg/#{dirs[0...-1].join("/")}")
    mkdir_err = stderr.gets 
    return puts "Error: #{mkdir_err}, #{pkg_dir_of pkg}" if mkdir_err 
  end

  File.open(pkg_path_of(pkg), "w+") do |file|
    file.write GODOC_HEADER
    loop do 
      output = stdout.gets
      if output 
        file.write(output)
      else
        break 
      end
    end
  end 

  puts "generated #{pkg}"
end

GODOC_HEADER = 
  '<link rel="stylesheet" type="text/css" href="/style.css">
  <link rel="stylesheet" type="text/css" href="/jquery.treeview.css">
  <script type="text/javascript" src="/jquery.min.js"></script>
  <script type="text/javascript" src="/jquery.treeview.js"></script>
  <script type="text/javascript" src="/jquery.treeview.edit.js"></script>
  <script type="text/javascript" src="/godoc.js"></script>
  '

GO_BUILT_IN_PKG = [
  "archive",
  "archive/tar",
  "archive/zip",
  "bufio",
  "bytes",
  "compress",
  "compress/bzip2",
  "compress/flate",
  "compress/gzip",
  "compress/lzw",
  "compress/zlib",
  "container",
  "container/heap",
  "container/list",
  "container/ring",
  "crypto",
  "crypto/aes",
  "crypto/cipher",
  "crypto/des",
  "crypto/dsa",
  "crypto/ecdsa",
  "crypto/elliptic",
  "crypto/hmac",
  "crypto/md5",
  "crypto/rand",
  "crypto/rc4",
  "crypto/rsa",
  "crypto/sha1",
  "crypto/sha256",
  "crypto/sha512",
  "crypto/subtle",
  "crypto/tls",
  "crypto/x509",
  "crypto/x509/pkix",
  "database",
  "database/sql",
  "database/sql/driver",
  "encoding",
  "encoding/ascii85",
  "encoding/asn1",
  "encoding/base32",
  "encoding/base64",
  "encoding/binary",
  "encoding/csv",
  "encoding/hex",
  "encoding/json",
  "encoding/pem",
  "encoding/xml",
  "errors",
  "expvar",
  "flag",
  "fmt",
  "hash",
  "hash/adler32",
  "hash/crc32",
  "hash/crc64",
  "hash/fnv",
  "html",
  "html/template",
  "image",
  "image/color",
  "image/color/palette",
  "image/draw",
  "image/gif",
  "image/internal",
  "image/internal/imageutil",
  "image/jpeg",
  "image/png",
  "index",
  "index/suffixarray",
  "internal",
  "internal/race",
  "internal/singleflight",
  "internal/syscall",
  "internal/syscall/unix",
  "internal/syscall/windows",
  "internal/syscall/windows/registry",
  "internal/testenv",
  "internal/trace",
  "io",
  "io/ioutil",
  "log",
  "log/syslog",
  "math",
  "math/big",
  "math/cmplx",
  "math/rand",
  "mime",
  "mime/multipart",
  "mime/quotedprintable",
  "net",
  "net/http",
  "net/http/cgi",
  "net/http/cookiejar",
  "net/http/fcgi",
  "net/http/httptest",
  "net/http/httputil",
  "net/http/internal",
  "net/http/pprof",
  "net/internal",
  "net/internal/socktest",
  "net/mail",
  "net/rpc",
  "net/rpc/jsonrpc",
  "net/smtp",
  "net/textproto",
  "net/url",
  "os",
  "os/exec",
  "os/signal",
  "os/user",
  "path",
  "path/filepath",
  "reflect",
  "regexp",
  "regexp/syntax",
  "runtime",
  "runtime/internal",
  "runtime/internal/atomic",
  "runtime/internal/sys",
  "runtime/msan",
  "runtime/pprof",
  "runtime/race",
  "runtime/trace",
  "sort",
  "strconv",
  "strings",
  "sync",
  "sync/atomic",
  "syscall",
  "testing",
  "testing/iotest",
  "testing/quick",
  "text",
  "text/scanner",
  "text/tabwriter",
  "text/template",
  "text/template/parse",
  "time",
  "unicode",
  "unicode/utf16",
  "unicode/utf8",
  "unsafe"
]

desc "Generate the docunment given named pkg"
task :generate_document, [:pkg] do |t, args|
  generate(args[:pkg])  
end



desc "Generate all ocument"
task :generate_all_document do
  go_root_src_path = "#{ENV['GOROOT']}/src/"

  paths = go_root_src_path.empty? ? GO_BUILT_IN_PKG : all_go_builtin_pkgs(go_root_src_path) 
  paths.each do |path|
    generate path 
  end
end

