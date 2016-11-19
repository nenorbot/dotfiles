{:user {:plugins      [[cider/cider-nrepl "0.15.0-SNAPSHOT"]
                       [refactor-nrepl "2.3.0-SNAPSHOT"]
                       [lein-ancient "0.6.7"]
                       [lein-ring "0.9.6"]
                       [lein-environ "1.0.3"]
                       [lein-cljsbuild "1.1.0"]
                       [lein-kibit "0.1.2"]
                       [lein-repetition-hunter "0.1.0-SNAPSHOT"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]
                       [repetition-hunter "1.0.0"]]
	:jvm-opts     ["-XX:MaxPermSize=200M"]}
 :env   {:squiggly {:checkers [:kibit]}}}
