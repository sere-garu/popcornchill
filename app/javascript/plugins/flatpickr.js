import flatpickr from "flatpickr"
import "flatpickr/dist/themes/dark.css"

flatpickr(".datepicker", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
})
