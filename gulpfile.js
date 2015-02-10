var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    plumber = require('gulp-plumber');

gulp.task('coffee', function() {
    return gulp.src(
            '*.coffee'
        )
        .pipe(plumber())
        .pipe(coffee({
            bare: true
        }))
        .pipe(gulp.dest('.'));
});

gulp.task('watch', function() {
    gulp.watch(['./*.coffee'], ['coffee']);
});
