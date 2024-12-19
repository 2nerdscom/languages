# We run the benchmark with input.txt as arguments
# unless the script is run with arguments, then those will be used instead
# With arguments the check will be skipped, unless the only argument is "check"
# The special argument "check" makes the input always input.txt, and skips the benchmark

num_script_args="${#}"
script_args="${*}"
if [ "${script_args}" = "check" ]; then
  args=$(cat input.txt)
else
  args=${script_args:-$(cat input.txt)}
fi

function check {
  if [ ${num_script_args} -eq 0 ] || [ "${script_args}" = "check" ]; then
    echo "Checking $1"
    output=$(${2} ${3})
    if ! ./check.sh "$output"; then
      echo "Check failed for $1."
      return 1
    fi
  fi
}

function run {
  echo ""
  if [ -f ${2} ]; then
    check "${1}" "${3}" "${4}"
    if [ ${?} -eq 0 ] && [ "${script_args}" != "check" ]; then
      echo "Benchmarking $1"
      hyperfine -i --shell=none --runs 3 --warmup 2 "${3} ${4}" | cut -c1-100
    fi
  else
    echo "No executable or script found for $1. Skipping."
  fi
}

# run "Language" "Executable" "Command" "Arguments"
#run "Ada" "./ada/code" "./ada/code" "${args}"
#run "AWK" "./awk/code.awk" "awk -f ./awk/code.awk" "${args}"
#run "Babashka" "bb/code.clj" "bb bb/code.clj" "${args}"
run "Bun (Compiled)" "./js/bun" "./js/bun" "${args}"
run "Bun (jitless)" "./js/code.js" "bun ./js/code.js" "BUN_JSC_useJIT=0" "${args}"
run "Bun" "./js/code.js" "bun ./js/code.js" "${args}"
run "C" "./c/code" "./c/code" "${args}"
run "C#" "./csharp/code" "./csharp/code" "${args}"
#run "C# AOT" "./csharp/code-aot/code" "./csharp/code-aot/code" "${args}"
run "Chez Scheme" "./chez/code.so" "chez --program ./chez/code.so" "${args}"
run "Clojure" "./clojure/classes/code.class" "java -cp clojure/classes:$(clojure -Spath) code" "${args}"
run "Clojure Native" "./clojure-native-image/code" "./clojure-native-image/code" "${args}"
run "COBOL" "./cobol/main" "./cobol/main" "${args}"
run "Common Lisp" "./common-lisp/code" "sbcl --script common-lisp/code.lisp" "${args}"
run "CPP" "./cpp/code" "./cpp/code" "${args}"
run "Crystal" "./crystal/code" "./crystal/code" "${args}"
#run "D" "./d/code" "./d/code" "${args}"
run "Dart" "./dart/code" "./dart/code" "${args}"
run "Deno (jitless)" "./js/code.js" "deno --v8-flags=--jitless ./js/code.js" "${args}"
run "Deno" "./js/code.js" "deno run ./js/code.js" "${args}"
run "Elixir" "./elixir/bench.exs" "elixir ./elixir/bench.exs" "${args}"
run "Emojicode" "./emojicode/code" "./emojicode/code" "${args}"
run "F#" "./fsharp/code" "./fsharp/code" "${args}"
#run "F# AOT" "./fsharp/code-aot/code" "./fsharp/code-aot/code" "${args}"
run "Fortran" "./fortran/code" "./fortran/code" "${args}"
run "Free Pascal" "./fpc/code" "./fpc/code" "${args}"
run "Go" "./go/code" "./go/code" "${args}"
run "Haskell" "./haskell/code" "./haskell/code" "${args}"
#run "Haxe JVM" "haxe/code.jar" "java -jar haxe/code.jar" "${args}" # was getting errors running `haxelib install hxjava` 
run "Inko" "./inko/code" "./inko/code" "${args}"
run "Java" "./jvm/code.class" "java jvm.code" "${args}"
#run "Java Native" "./jvm.code" "./jvm.code" "${args}"
run "Julia" "./julia/code.jl" "julia ./julia/code.jl" "${args}"
run "Kotlin JVM" "kotlin/code.jar" "java -jar kotlin/code.jar" "${args}"
run "Kotlin Native" "./kotlin/code.kexe" "./kotlin/code.kexe" "${args}"
run "Lua" "./lua/code.lua" "lua ./lua/code.lua" "${args}"
run "LuaJIT" "./lua/code" "luajit ./lua/code" "${args}"
#run "MAWK" "./awk/code.awk" "mawk -f ./awk/code.awk" "${args}"
run "Nim" "./nim/code" "./nim/code" "${args}"
run "Node (jitless)" "./js/code.js" "node --jitles ./js/code.js" "${args}"
run "Node" "./js/code.js" "node ./js/code.js" "${args}"
run "Objective-C" "./objc/code" "./objc/code" "${args}"
#run "Octave" "./octave/code.m" "octave ./octave/code.m 40" "${args}"
run "Odin" "./odin/code" "./odin/code" "${args}"
run "PHP JIT" "./php/code.php" "php -dopcache.enable_cli=1 -dopcache.jit=on -dopcache.jit_buffer_size=64M ./php/code.php" "${args}"
run "PHP" "./php/code.php" "php ./php/code.php" "${args}"
run "PyPy" "./py/code.py" "pypy ./py/code.py" "${args}"
run "Python" "./py/code.py" "python3.13 ./py/code.py" "${args}"
#run "R" "./r/code.R" "Rscript ./r/code.R" "${args}"
run "Ruby YJIT" "./ruby/code.rb" "miniruby --yjit ./ruby/code.rb" "${args}"
run "Ruby" "./ruby/code.rb" "ruby ./ruby/code.rb" "${args}"
run "Rust" "./rust/target/release/code" "./rust/target/release/code" "${args}"
run "Scala" "./scala/code" "./scala/code" "${args}"
run "Scala-Native" "./scala/code-native" "./scala/code-native" "${args}"
run "Swift" "./swift/code" "./swift/code" "${args}"
run "V" "./v/code" "./v/code" "${args}"
run "Zig" "./zig/code" "./zig/code" "${args}"
