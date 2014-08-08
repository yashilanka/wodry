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
                src: 'dist/wodry.js',
                dest: 'dist/wodry.min.js'
            }
        },
        watch: {
            dev: {
                files: ['src/*', 'test/*.coffee'],
                tasks: ['coffee', 'connect:livereload', 'notify:test']
            }
        },
        clean: {
            target: ['dist']
        },
        notify: {
            test: {
                options: {
                    title: 'Exam.js',
                    message: 'Tests passed!'
                }
            }
        },
        coffee: {
            compile: {
                files: {
                    'dist/wodry.js': ['src/*.coffee']
                }
            },
        }
    });

    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-notify');
    grunt.loadNpmTasks('grunt-contrib-coffee');

    grunt.registerTask('default', ['clean', 'coffee', 'uglify']);
    grunt.registerTask('dev', ['watch']);
};
