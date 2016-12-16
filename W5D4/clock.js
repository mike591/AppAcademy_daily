class Clock {
  constructor() {
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.

    const currentDate = new Date();

    this.date = {
      hours: currentDate.getHours(),
      minutes: currentDate.getMinutes(),
      seconds: currentDate.getSeconds()
    };

    this.printTime();

    setInterval(() => this._tick(), 1000);
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    console.log(`${this.date.hours}:${this.date.minutes}:${this.date.seconds}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    this.date.seconds += 1;
    if (this.date.seconds > 59) {
      this.date.minutes += 1;
      this.date.seconds = 0;
    }

    if (this.date.minutes > 59) {
      this.date.hours += 1;
      this.date.minutes = 0;
    }

    if (this.date.hours > 12) {
      this.date.hours = 1;
    }

    this.printTime();
  }
}

const clock = new Clock();
