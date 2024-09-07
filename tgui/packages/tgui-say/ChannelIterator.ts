<<<<<<< HEAD
export type Channel =
  | 'Say'
  | 'Radio'
  | 'Me'
  // SKYRAT EDIT ADDITION START
  | 'Whis'
  | 'LOOC'
  // SKYRAT EDIT ADDITION END
  | 'OOC'
  | 'Admin';
=======
export type Channel = 'Say' | 'Radio' | 'Me' | 'OOC' | 'Admin';
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3

/**
 * ### ChannelIterator
 * Cycles a predefined list of channels,
 * skipping over blacklisted ones,
 * and providing methods to manage and query the current channel.
 */
export class ChannelIterator {
  private index: number = 0;
<<<<<<< HEAD
  private readonly channels: Channel[] = [
    'Say',
    'Radio',
    'Me',
    // SKYRAT EDIT ADDITION
    'Whis',
    'LOOC',
    // SKYRAT EDIT ADDITION
    'OOC',
    'Admin',
  ];
  private readonly blacklist: Channel[] = ['Admin'];
  private readonly quiet: Channel[] = ['OOC', 'LOOC', 'Admin']; // SKYRAT EDIT CHANGE (Add LOOC)
=======
  private readonly channels: Channel[] = ['Say', 'Radio', 'Me', 'OOC', 'Admin'];
  private readonly blacklist: Channel[] = ['Admin'];
  private readonly quiet: Channel[] = ['OOC', 'Admin'];
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3

  public next(): Channel {
    if (this.blacklist.includes(this.channels[this.index])) {
      return this.channels[this.index];
    }

    for (let index = 1; index <= this.channels.length; index++) {
      let nextIndex = (this.index + index) % this.channels.length;
      if (!this.blacklist.includes(this.channels[nextIndex])) {
        this.index = nextIndex;
        break;
      }
    }

    return this.channels[this.index];
  }

  public set(channel: Channel): void {
    this.index = this.channels.indexOf(channel) || 0;
  }

  public current(): Channel {
    return this.channels[this.index];
  }

  public isSay(): boolean {
    return this.channels[this.index] === 'Say';
  }

  public isVisible(): boolean {
    return !this.quiet.includes(this.channels[this.index]);
  }

  public reset(): void {
    this.index = 0;
  }
}
