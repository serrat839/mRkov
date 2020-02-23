search_vector <- c("b")
search_vector2 <- c("a")

bank <- c("a","b","c","d","e","f","g","h","i","j","k","l","m",
          "n","o","p","q","r","s","t","u","v","w","x","y","z",
          "a","b","b","c","v","b","b")

bank1 <- bank == search_vector
bank2 <- bank == search_vector2

num_bank1 <- as.numeric(bank1) * 71
num_bank2 <- as.numeric(bank2) * 73

sum_bank <- num_bank1 + num_bank2

history_list <- c("b", "b", "c")


find_next <- function(history, bank) {
  primes <- c(11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
              47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103,
              107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163,
              167, 173, 179, 181, 191, 193, 197, 199)
  aux_list <- list()
  for (x in history) {
    aux_list[[as.character(length(aux_list))]] <- bank == x
  }

  print(aux_list)
  win_rar_is_you <- aux_list[[1]]
  aux_list[[1]] <- NULL
  for (x in aux_list) {
    part_twon <- c(FALSE, win_rar_is_you[-length(win_rar_is_you)])
    print("first")
    print(x)
    print("second")
    print(part_twon)
    win_rar_is_you <- (x & part_twon)
  }

  win_rar_is_you <- c(FALSE, win_rar_is_you[-length(win_rar_is_you)])
  return(win_rar_is_you)
}

holding <- find_next(history_list, bank)
bank[holding]

