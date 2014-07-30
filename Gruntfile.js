module.exports = function(grunt) {
    grunt.initConfig({
        uglify: {
            options: {
                mangle: true,
                compress: true,
                sourceMap: 'dist/wodry.js.map',
                banner: '/* Sergey Golovin 2014 golovim@gmail.com */\n'
            },
            target: {
                src: 'build/wodry.js',
                dest: 'dist/wodry.min.js'
            }
        },
        watch: {
            dev: {
                files: ['src/*', 'test/*.coffee'],
                tasks: ['coffee','test', 'notify:test']
            }
        },
        clean: {
            target: ['dist']
        },
        karma: {
            dev: {
                configFile: 'karma.conf.js',
                browsers: ['Firefox']
            },
            travis: {
                configFile: 'karma.conf.js',
                browsers: ['Firefox']
            },
            build: {
                configFile: 'karma.conf.js',
                browsers: ['Safari', 'Chrome', 'Firefox']
            }
        },
        connect: {
            server: {
                options: {
                    port: 3333,
                    open: {
                        target: 'http://localhost:3333'
                    }
                }
            }
        },
        notify: {
            test: {
                options: {
                    title: 'Exam.js',
                    message: 'Tests passed!'
                }
            }
        },
        coveralls: {
            options: {
                // LCOV coverage file relevant to every target
                src: 'coverage/**/*.info'
            }
        },
        jasmine: {
            exam: {
                src: 'build/**/*.js',
                options: {
                    specs: 'test/*Spec.js',
                    helpers: 'test/*Helper.js'
                }
            }
        },
        coffee: {
            compile: {
                files: {
                    'build/wodry.js': ['src/*.coffee']
                }
            },
        }
    });

    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-karma');
    grunt.loadNpmTasks('grunt-notify');
    grunt.loadNpmTasks('grunt-coveralls');
    grunt.loadNpmTasks('grunt-contrib-jasmine');
    grunt.loadNpmTasks('grunt-contrib-coffee');

    grunt.registerTask('test', ['jasmine']);
    grunt.registerTask('travis-ci-test', ['coffee','karma:travis', 'coveralls']);
    grunt.registerTask('default', ['clean','coffee', 'test', 'uglify', 'coveralls']);
    grunt.registerTask('dev', ['watch']);
};
