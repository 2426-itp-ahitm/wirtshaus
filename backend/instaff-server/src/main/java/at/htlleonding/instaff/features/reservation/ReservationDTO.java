package at.htlleonding.instaff.features.reservation;

import java.time.LocalTime;

public record ReservationDTO(
        Long id,
        String name,
        String infos,
        int numberOfPeople,
        LocalTime startTime,
        LocalTime endTime,
        Long shift
) {
}
