library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(tidytext)
library(ggplot2)
library(forcats)
library(tibble)
library(scales)
library(quanteda)
library(quanteda.textstats)

file_a <- "text/A07594__Circle_of_Commerce.txt"
file_b <- "text/B14801__Free_Trade.txt"
file_c <- "text/A06785.txt"

text_a <- read_file(file_a)
text_b <- read_file(file_b)
text_c <- read_file(file_c)

custom_stop <- c(
  "vnto", "haue", "doo", "hath", "bee", "ye", "thee", "hee", "shall",
  "hast", "doe", "beene", "thereof", "thus"
)

bing <- get_sentiments("bing")

# Raw sentiment 

texts <- tibble(
  doc_title = c("The Circle of Commerce", "Free Trade"),
  text = c(text_a, text_b)
)

tidy_texts <- texts %>%
  mutate(text = str_replace_all(text, "ſ", "s")) %>%
  unnest_tokens(word, text, to_lower = TRUE) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!word %in% custom_stop)

text_sentiment <- tidy_texts %>%
  inner_join(bing, by = "word")

sentiment_summary <- text_sentiment %>%
  count(doc_title, sentiment) %>%
  pivot_wider(
    names_from = sentiment,
    values_from = n,
    values_fill = 0
  ) %>%
  mutate(net_sentiment = positive - negative)

# TF-IDF weighted sentiment

texts_vec <- c(
  "The Circle of Commerce" = text_a,
  "Free Trade"             = text_b,
  "Third Text A06785"      = text_c
)
texts_vec <- str_replace_all(texts_vec, "ſ", "s")

corp <- corpus(texts_vec)

toks <- tokens(
  corp,
  remove_punct   = TRUE,
  remove_numbers = TRUE,
  remove_symbols = TRUE
)
toks <- tokens_tolower(toks)
toks <- tokens_remove(toks, pattern = c(stopwords("en"), custom_stop))

dfm_mat   <- dfm(toks)
tfidf_dfm <- dfm_tfidf(dfm_mat)

tfidf_tidy <- convert(tfidf_dfm, to = "data.frame") %>%
  rename(doc_title = doc_id) %>%
  pivot_longer(
    cols = -doc_title,
    names_to = "word",
    values_to = "tf_idf"
  ) %>%
  filter(tf_idf != 0) %>%
  filter(doc_title %in% c("The Circle of Commerce", "Free Trade"))

sentiments_tfidf <- tfidf_tidy %>%
  inner_join(bing, by = "word") %>%
  arrange(desc(tf_idf))

weighted_sentiments <- sentiments_tfidf %>%
  summarise(total_tf_idf = sum(tf_idf), .by = c(doc_title, sentiment)) %>%
  pivot_wider(
    names_from = sentiment,
    values_from = total_tf_idf,
    values_fill = 0
  ) %>%
  mutate(net_tf_idf = positive - negative)



final_summary <- sentiment_summary %>%
  left_join(weighted_sentiments, by = "doc_title",
            suffix = c("_raw", "_tfidf"))

final_summary




 