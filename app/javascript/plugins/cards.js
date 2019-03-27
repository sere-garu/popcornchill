// import swing from 'swing';
// import swing from "swing"

// var cardsContainers = document.querySelectorAll(".flipper");

// cardsContainers.forEach(function(element) {
// element.querySelectorAll(".touchable-front").forEach(function(toucharea){
// toucharea.addEventListener("click", function( event ) {
//     event.preventDefault();
//     element.classList.toggle("turn");
//   });
// });
// element.querySelectorAll(".touchable-back").forEach(function(toucharea){
// toucharea.addEventListener("click", function( event ) {
//     event.preventDefault();
//     element.classList.toggle("turn");
//   });
// });
// });


// SWING
const config = {
  /**
   * Invoked in the event of dragmove.
   * Returns a value between 0 and 1 indicating the completeness of the throw out condition.
   * Ration of the absolute distance from the original card position and element width.
   *
   * @param {number} xOffset Distance from the dragStart.
   * @param {number} yOffset Distance from the dragStart.
   * @param {HTMLElement} element Element.
   * @returns {number}
   */
  throwOutConfidence: (xOffset, yOffset, element) => {
    const xConfidence = Math.min(Math.abs(xOffset) / element.offsetWidth, 1);
    const yConfidence = Math.min(Math.abs(yOffset) / element.offsetHeight, 1);
    var confidence = Math.max(xConfidence, yConfidence);
    var confidenceNew = confidence + 0.8;
    if (confidenceNew > 1) confidenceNew = 1;
    return confidenceNew;
  }
};



document.addEventListener('DOMContentLoaded', function () {
    var stack;

    var swipeYes = function (element) {
      swipe(element, "yep");
    };


    var swipeNo = function (element) {
      swipe(element, "nope");
    };

    var swipe = function (element, preference) {
      var movie_id = element.dataset.movieId;
      var event_id = element.dataset.eventId;

      let url = '/events/'+event_id+'/results';

      let data = {
        preference: preference,
        movie_id: movie_id,
        event_id: event_id,
      }

      fetch(url, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          "credentials": 'include'
        },
        method: 'POST',
        body: JSON.stringify(data)
      }).then(function(response) {
        return response.json();
      }).then(function(data) {
      });
    };



    stack = window.swing.Stack(config);

    [].forEach.call(document.querySelectorAll('.card-trip'), function (targetElement) {
        stack.createCard(targetElement);
        targetElement.classList.add('in-deck');
    });

    stack.on('throwout', function (e) {
      let direction = e.throwDirection.toString();

      if (direction === "Symbol(LEFT)") {
        swipeNo(e.target)
      } else  {
        swipeYes(e.target)
      }

      e.target.remove()
    });

    stack.on('throwin', function (e) {
        // swipe(e.target)
        // e.target.classList.add('in-deck');
        // e.target.remove()
    });
});
