# Build the data frames from the .dat file (its a "::" separated file) with their correspondent column variable names.
ratings_file2 <- "data/ml-10M100K/ratings.dat"
ratings <- as.data.frame(str_split(read_lines(ratings_file2), fixed("::"), simplify = TRUE),
                         stringsAsFactors = FALSE)
colnames(ratings) <- c("userId", "movieId", "rating", "timestamp")
# Specify  variable number formats for ease of operations.
ratings <- ratings %>%
  mutate(userId = as.integer(userId),
         movieId = as.integer(movieId),
         rating = as.numeric(rating),
         timestamp = as.integer(timestamp))

movies_file2 <- "data/ml-10M100K/movies.dat"
movies <- as.data.frame(str_split(read_lines(movies_file2), fixed("::"), simplify = TRUE),
                        stringsAsFactors = FALSE)
colnames(movies) <- c("movieId", "title", "genres")
movies <- movies %>%
  mutate(movieId = as.integer(movieId))

#Define the "movielens" data set by left-joining the ratings and movies.
movielens <- left_join(ratings, movies, by = "movieId")

save(movielens, file = "rda/movielens.rda")