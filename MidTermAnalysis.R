library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(tidytext)
library(ggplot2)
library(forcats)
library(tibble)
library(scales)
library(purrr)
library(quanteda)
library(quanteda.textstats)
library(udpipe)

list.files("midterm_texts")

bauhaus           <- read_file("midterm_texts/Bauhaus Manifesto.txt")
blanco            <- read_file("midterm_texts/Blanco.txt")
cannibalism       <- read_file("midterm_texts/Cannibalism.txt")
cyborg            <- read_file("midterm_texts/Cyborg.txt")
dada              <- read_file("midterm_texts/Dada Manifesto.txt")
futurist_woman    <- read_file("midterm_texts/Futurist Woman.txt")
futurism          <- read_file("midterm_texts/Manifesto of Futurism.txt")
surrealism        <- read_file("midterm_texts/Manifesto of Surrealism.txt")
purism            <- read_file("midterm_texts/Purism Manifesto.txt")
revolutionary     <- read_file("midterm_texts/Revolutionary.txt")
situationism      <- read_file("midterm_texts/Situationism.txt")
suprematism       <- read_file("midterm_texts/Suprematism.txt")
futurist_painting <- read_file("midterm_texts/Technical Manifesto of Futurist Painting.txt")

texts <- tibble(
  doc_title = c("bauhaus", "blanco", "cannibalism", "cyborg", "dada",
                "futurist_woman", "futurism", "surrealism", "purism",
                "revolutionary", "situationism", "suprematism",
                "futurist_painting"),
  text      = c(bauhaus, blanco, cannibalism, cyborg, dada,
                futurist_woman, futurism, surrealism, purism,
                revolutionary, situationism, suprematism,
                futurist_painting)
)

#constructing DFM
texts <- texts %>%
  mutate(text = text %>%
           str_remove_all("<[^>]+>") %>%
           str_remove_all("&[a-zA-Z]+;|&#\\d+;") %>%
           str_replace_all("[\u2018\u2019]", "'") )
         
corp <- corpus(texts, text_field = "text", docid_field = "doc_title")
  toks <- tokens(
    corp,
    remove_punct   = TRUE,
    remove_numbers = TRUE,
    remove_symbols = TRUE
    
  )
toks <- tokens_tolower(toks)
toks <- tokens_remove(toks, stopwords("en"))
toks <- tokens_wordstem(toks, language = "en")
dfm_mat <- dfm(toks)

#TF-IDF
dfm_tfidf <- dfm_tfidf(dfm_mat)
dfm_tfidf
topfeatures(dfm_tfidf, 20)


tfidf_long <- convert(dfm_tfidf, to = "data.frame") %>%
  pivot_longer(-doc_id, names_to = "term", values_to = "tfidf") %>%
  filter(tfidf > 0)                      

top_terms <- tfidf_long %>%
  group_by(doc_id) %>%
  slice_max(tfidf, n = 15, with_ties = FALSE) %>%
  mutate(rank = row_number()) %>%
  ungroup()

top_terms_table <- top_terms %>%
  arrange(doc_id, rank) %>%
  mutate(term_score = paste0(term, " (", round(tfidf, 1), ")")) %>%
  group_by(doc_id) %>%
  summarise(top_terms = paste(term_score, collapse = ", "))

write_csv(top_terms, "top_tfidf_terms_long.csv")
write_csv(top_terms_table, "top_tfidf_terms_by_document.csv")

#Pearson Correlation
dfm_trimmed <- dfm_trim(dfm_mat, min_termfreq = 5)
sim_r <- textstat_simil(
  dfm_trimmed, 
  margin = "documents", 
  method = "correlation")

r_mat <- round(as.matrix(sim_r), 3)
heat_df <- as.data.frame(r_mat) %>%
  rownames_to_column("doc_i") %>%
  pivot_longer(-doc_i, names_to = "doc_j", values_to = "r")

ggplot(heat_df, aes(x = doc_j, y = doc_i, fill = r)) +
  geom_tile() +
  coord_fixed() +
  scale_fill_gradient2(
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = 0
  ) +
  labs(
    title = "Pearson Correlation Between Documents",
    x = NULL,
    y = NULL,
    fill = "Correlation"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid = element_blank()
  )
ggsave("pearson_heatmap.png", width = 8, height = 7, dpi = 300)
write_csv(as.data.frame(r_mat) %>% rownames_to_column("document"),
          "pearson_correlation_matrix.csv")

#Syntactic Complexity
#suprematism vs futurist_woman
texts_df <- tibble(
  document = c("Suprematism", "Futurist Woman"),
  author   = c("Kazimir Malevich", "Valentine de Saint Point"),
  text     = c(texts$text[texts$doc_title == "suprematism"],
               texts$text[texts$doc_title == "futurist_woman"])
)

ud_model <- udpipe_load_model("english-ewt-ud-2.5-191206.udpipe")

anno_df <- texts_df %>%
  mutate(
    anno = map2(text, document, ~ udpipe_annotate(ud_model, x = .x, doc_id = .y) %>%
                  as.data.frame())
  ) %>%
  select(anno) %>%
  unnest(anno) %>%
  rename(document = doc_id) %>%
  select(
    document,
    paragraph_id,
    sentence_id,
    sentence,
    token_id,
    token,
    lemma,
    upos,          # part of speech
    feats,         # grammatical features (e.g., verb form)
    head_token_id, # head of dependency relation
    dep_rel        # dependency relation type
  )

syntax_df <- anno_df %>%
  mutate(
    is_word = upos != "PUNCT", 
    is_clause = (upos %in% c("VERB", "AUX")) &
      str_detect(coalesce(feats, ""), "VerbForm=Fin"),
    is_dep_clause = dep_rel %in% c(
      "advcl", #adverbial clause 
      "ccomp", # clausal complement
      "xcomp", #open clausal complement
      "acl", #adnomial clause
      "acl:relcl" #relative clause
    ),
    is_coord = dep_rel %in% c("conj", "cc"),
    is_complex_nominal = dep_rel %in% c(
      "amod", # adjective modifier ("big cup")
      "nmod", #nominal modifier ("cup of tea")
      "compound", # compound ("lemon tea")
      "appos" #apposition ("tea, my favorite!")
    )
  )

sentence_df <- syntax_df %>%
  filter(is_word) %>%           #count words (not punctuation)
  group_by(document, sentence_id) %>%   #group by document and sentence
  summarise(
    words          = n(),   #number of words per sentence
    clauses        = sum(is_clause), # number of clauses per sentence
    dep_clauses    = sum(is_dep_clause), #number of dependent clauses per sentence
    .groups = "drop"
  )

#mean length of sentence
mls_df <- sentence_df %>%
  group_by(document) %>%
  summarise(
    MLS = mean(words), # Average words per sentence
    .groups = "drop"
  )

#clauses per sentence
clausal_density_df <- sentence_df %>%
  group_by(document) %>%
  summarise(
    sentences = n(),
    clauses   = sum(clauses),
    C_per_S   = clauses / sentences,
    .groups = "drop"
  )

#count dependent clauses
subordination_df <- sentence_df %>%
  group_by(document) %>%
  summarise(
    clauses = sum(clauses),
    dep_clauses = sum(dep_clauses),
    sentences = n(),
    DC_per_C = dep_clauses / pmax(clauses, 1), #avoid division by 0 (shouldn't happen, but if no clauses were detected in the sentence, we still want it to run)
    DC_per_S = dep_clauses / sentences,
    .groups = "drop"
  )

#count coordination
coordination_df <- syntax_df %>%
  group_by(document) %>%
  summarise(
    coord_relations = sum(is_coord),
    clauses         = sum(is_clause),
    sentences       = n_distinct(sentence_id),
    Coord_per_C     = coord_relations / pmax(clauses, 1),
    Coord_per_S     = coord_relations / sentences,
    .groups = "drop"
  )

#count nominals
nominal_df <- syntax_df %>%
  group_by(document) %>%
  summarise(
    complex_nominals = sum(is_complex_nominal),
    clauses          = sum(is_clause),
    sentences        = n_distinct(sentence_id),
    CN_per_C         = complex_nominals / pmax(clauses, 1),
    CN_per_S         = complex_nominals / sentences,
    .groups = "drop"
  )

# Combine all measures
all_measures <- mls_df %>%  # ← Added mls_df %>%
  left_join(clausal_density_df %>% select(document, C_per_S), by = "document") %>%
  left_join(subordination_df %>% select(document, DC_per_C, DC_per_S), by = "document") %>%
  left_join(coordination_df %>% select(document, Coord_per_C, Coord_per_S), by = "document") %>%
  left_join(nominal_df %>% select(document, CN_per_C, CN_per_S), by = "document")

all_measures_table <- all_measures %>%
  mutate(across(where(is.numeric), ~ round(.x, 2)))
all_measures_table
write_csv(all_measures_table, "syntactic_complexity_summary.csv")

# Reshape for plotting
syntax_long <- all_measures %>%  # ← Added %>%
  pivot_longer(
    cols = -document,
    names_to = "Measure",
    values_to = "Value"
  ) %>%
  mutate(
    Category = case_when(
      Measure == "MLS" ~ "Sentence Length",
      Measure == "C_per_S" ~ "Clausal Density",
      Measure %in% c("DC_per_C", "DC_per_S") ~ "Subordination",
      Measure %in% c("Coord_per_C", "Coord_per_S") ~ "Coordination",
      Measure %in% c("CN_per_C", "CN_per_S") ~ "Phrasal Complexity"
    )
  )

# Plot
ggplot(syntax_long, aes(x = Measure, y = Value, fill = document)) +
  geom_col(position = "dodge", width = 0.7) +
  facet_wrap(~Category, scales = "free", ncol = 2) +
  scale_fill_brewer(palette = "Set1") +
  labs(
    title = "Syntactic Complexity: Complete Profile",
    subtitle = "Comparing multiple dimensions of syntactic complexity",
    x = NULL,
    y = "Value",
    fill = "Document"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  )
ggsave("syntactic_complexity_profile.png", width = 10, height = 8, dpi = 300)

 
