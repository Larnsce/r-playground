
# get timeline data --------------------

my_name <- userTimeline("larnsce", n = 3200, includeRts=TRUE)

my_name_df <- twListToDF(my_name) %>% as_tibble()

# get friends and follower data ----------

user <- getUser("larnsce")
friends <- user$getFriends() # who I follow
friends_df <- twListToDF(friends) %>% as_tibble()

followers <- user$getFollowers() # my followers
followers_df <- twListToDF(followers) %>% as_tibble()


# analyse followers data

followers_df %>% 
        count(lang) %>% 
        droplevels() %>%
        ggplot(aes(x = reorder(lang, desc(n)), y = n)) +
        geom_bar(stat = "identity", color = palette_light()[1], fill = palette_light()[1], alpha = 0.8) +
        theme_tq() +
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
        labs(x = "language ISO 639-1 code",
             y = "number of followers")

followers_df %>%
        ggplot(aes(x = log2(followersCount))) +
        geom_density(color = palette_light()[1], fill = palette_light()[1], alpha = 0.8) +
        theme_tq() +
        labs(x = "log2 of number of followers",
             y = "density")

followers_df %>%
        mutate(date = as.Date(created, format = "%Y-%m-%d"),
               today = as.Date("2017-06-07", format = "%Y-%m-%d"),
               days = as.numeric(today - date),
               statusesCount_pDay = statusesCount / days) %>%
        ggplot(aes(x = log2(statusesCount_pDay))) +
        geom_density(color = palette_light()[1], fill = palette_light()[1], alpha = 0.8) +
        theme_tq()

followers_df %>%
        mutate(date = as.Date(created, format = "%Y-%m-%d"),
               today = as.Date("2017-06-07", format = "%Y-%m-%d"),
               days = as.numeric(today - date),
               statusesCount_pDay = statusesCount / days) %>%
        select(screenName, followersCount, statusesCount_pDay) %>%
        arrange(desc(followersCount)) %>%
        top_n(10)


### tidy text analysis

data(stop_words)

tidy_descr <- followers_df %>%
        unnest_tokens(word, description) %>%
        mutate(word_stem = wordStem(word)) %>%
        anti_join(stop_words, by = "word") %>%
        filter(!grepl("\\.|http", word))


tidy_descr %>%
        count(word_stem, sort = TRUE) %>%
        filter(n > 20) %>%
        ggplot(aes(x = reorder(word_stem, n), y = n)) +
        geom_col(color = palette_light()[1], fill = palette_light()[1], alpha = 0.8) +
        coord_flip() +
        theme_tq() +
        labs(x = "",
             y = "count of word stem in all followers' descriptions")

tidy_descr %>%
        count(word_stem) %>%
        mutate(word_stem = removeNumbers(word_stem)) %>%
        with(wordcloud(word_stem, n, max.words = 100, colors = palette_light()))
