import flatpickr from "flatpickr"
import "flatpickr/dist/themes/dark.css"

flatpickr(".datepicker", {
    enableTime: true,
    disableMobile: false,
    dateFormat: "Y-m-d H:i",
})
