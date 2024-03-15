library(shiny)

# Define a list of words for the game
words <- c("hangman", "programming", "shiny", "authentication", "azure", "container")

ui <- fluidPage(
  
  tags$header(
    style = "background-color: #f2f2f2;
             padding: 10px;
             display: flex;
             justify-content: space-between;
             height: 50px;
             align-items: center;
             position: fixed;
             top: 0;
             width: 100%;
             margin-left: -15px;",
    titlePanel("Hangman Game"),
    # logout button
    tags$a(
      href = "/.auth/logout",
      tags$i(class = "fa fa-sign-out", style = "font-size: 20px; color: #000000; margin-right: 10px;"),
    )
  ),
  
  mainPanel(
    style = "margin-top: 50px;",
    h3("Guess the word!"),
    textOutput("word_display"),
    br(),
    textInput("guess_input", "Enter a letter:"),
    tagAppendAttributes(style = "background-color:steelblue;color:white;",
                        actionButton("guess_button", icon = icon("lightbulb"), "Guess")),
    br(),
    br(),
    h4("Incorrect Guesses:"),
    textOutput("incorrect_guesses"),
    br(),
    h4("Remaining Chances:"),
    textOutput("remaining_chances"),
    br(),
    tagAppendAttributes(style = "background-color:orange;color:white;",
                        actionButton("reset_button", icon = icon("redo"), "Reset"))
  )
)

server <- function(input, output, session) {
  
  # Initialize game state
  game_state <- reactiveValues(
    word = sample(words, 1),  # Randomly select a word from the list
    guessed_letters = character(0),  # Store guessed letters
    incorrect_guesses = 0,  # Count of incorrect guesses
    remaining_chances = 7  # Total chances before game over
  )
  
  # Function to update game state based on user guess
  update_game_state <- function() {
    
    guess <- tolower(substr(input$guess_input, 1, 1))  # Extract first character of user's guess
    
    if (guess %in% game_state$guessed_letters) {
      # Letter has already been guessed, do nothing
      return()
    }
    
    game_state$guessed_letters <- c(game_state$guessed_letters, guess)
    
    if (!(guess %in% strsplit(game_state$word, "")[[1]])) {
      # Incorrect guess
      game_state$incorrect_guesses <- game_state$incorrect_guesses + 1
    }
    
    if (game_state$incorrect_guesses >= game_state$remaining_chances) {
      # Game over
      showGameOverMessage()
    }
  }
  
  # Action when the guess button is clicked
  observeEvent(input$guess_button, {
    update_game_state()
  })
  
  # Function to display the word with guessed letters filled in
  output$word_display <- renderText({
    word <- game_state$word
    guessed_letters <- game_state$guessed_letters
    
    displayed_word <- sapply(strsplit(word, "")[[1]], function(x) {
      if (x %in% guessed_letters) {
        x
      } else {
        "_"
      }
    })
    
    paste(displayed_word, collapse = " ")
  })
  
  # Display incorrect guesses
  output$incorrect_guesses <- renderText({
    if(length(game_state$guessed_letters) == 0){
      "No incorrect guesses yet 👀 "
    } else {
      paste(game_state$guessed_letters[!(game_state$guessed_letters %in% strsplit(game_state$word, "")[[1]])], collapse = ", ")
    }
  })
  
  # Display remaining chances
  output$remaining_chances <- renderText({
    game_state$remaining_chances - game_state$incorrect_guesses
  })
  
  # Function to display game over message
  showGameOverMessage <- function() {
    showModal(modalDialog(
      title = "Game Over",
      paste("You ran out of chances! The word was", game_state$word),
      easyClose = TRUE
    ))
    
    # Reset game state
    game_state$word <- sample(words, 1)
    game_state$guessed_letters <- character(0)
    game_state$incorrect_guesses <- 0
  }
  
  observeEvent(input$reset_button, {
    
    game_state$word <- sample(words, 1)
    game_state$guessed_letters <- character(0)
    game_state$incorrect_guesses <- 0
    game_state$remaining_chances <- 7
    
    updateTextInput(session = session,
                    inputId = "guess_input",
                    value = "")
    
  })
}

shinyApp(ui, server)
