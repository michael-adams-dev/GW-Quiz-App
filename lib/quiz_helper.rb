require 'tty-prompt'

module QuizHelper
  FACTS = ["The sky is blue", "It's Spring at the moment"]
  PROMPT = TTY::Prompt.new
  PICUKI = "https://www.picuki.com/profile/goodweekendquiz"
  PATH_TO_IMAGES = ["../public/imgs/questions.jpg", "../public/imgs/answers.jpg"]
end