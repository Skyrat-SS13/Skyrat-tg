import { useBackend } from '../backend';
import { Section, Button, NoticeBox, LabeledList, Stack } from '../components';
import { Window } from '../layouts';

export const EventPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    event_list = [],
    votes = [],
    end_time,
    vote_in_progress,
    previous_events,
    admin_mode,
    show_votes,
    next_vote_time,
  } = data;
  return (
    <Window
      title={"Event Panel"}
      width={500}
      height={840}
      theme={"admin"}>
      <Window.Content>
        <Stack vertical fill>
          {admin_mode ? (
            <>
              <Stack.Item>
                <Section title={"Event Control" + " | Next event: " + next_vote_time + " seconds"}>
                  <Button
                    icon="plus"
                    content="Start Admin Vote"
                    tooltip="Start a vote for the next event."
                    disabled={vote_in_progress}
                    onClick={() => act('start_vote_admin')} />
                  <Button
                    icon="plus"
                    content="Start Admin Chaos Vote"
                    tooltip="Start a chaos vote for the next event."
                    disabled={vote_in_progress}
                    onClick={() => act('start_vote_admin_chaos')} />
                  <Button
                    icon="user-plus"
                    content="Start Player Vote"
                    tooltip="This will start a vote that will be publically visible."
                    color="average"
                    disabled={vote_in_progress}
                    onClick={() => act('start_player_vote')} />
                  <Button
                    icon="user-plus"
                    content="Start Public Chaos Vote"
                    tooltip="This will start a vote that will be publically visible."
                    color="average"
                    disabled={vote_in_progress}
                    onClick={() => act('start_player_vote_chaos')} />
                  <Button
                    icon="stopwatch"
                    content="End Vote"
                    tooltip="End the current vote and execute the winning event."
                    disabled={!vote_in_progress}
                    onClick={() => act('end_vote')} />
                  <Button
                    icon="ban"
                    content="Cancel Vote"
                    tooltip="Cancel the current vote and reset the voting system."
                    disabled={!vote_in_progress}
                    onClick={() => act('cancel_vote')} />
                  <Button
                    icon="clock"
                    content="Rescedule Next Event"
                    tooltip="Rescedule the next timed event."
                    onClick={() => act('reschedule')} />
                </Section>
              </Stack.Item>
              <Stack.Item>
                <Section scrollable grow fill height="150px" title="Current Votes">
                  {vote_in_progress ? (
                    <LabeledList>
                      {votes.map(vote => (
                        <LabeledList.Item
                          key={vote.id}
                          label={vote.name}>
                          {vote.votes}
                        </LabeledList.Item>
                      ))}
                    </LabeledList>
                  ) : (
                    <NoticeBox>
                      No vote in progress.
                    </NoticeBox>
                  )}
                </Section>
              </Stack.Item>
            </>
          ) : (
            !!show_votes && (
              <Stack.Item>
                <Section scrollable grow fill height="150px" title="Current Votes">
                  {vote_in_progress ? (
                    <LabeledList>
                      {votes.map(vote => (
                        <LabeledList.Item
                          key={vote.id}
                          label={vote.name}>
                          {vote.votes}
                        </LabeledList.Item>
                      ))}
                    </LabeledList>
                  ) : (
                    <NoticeBox>
                      No vote in progress.
                    </NoticeBox>
                  )}
                </Section>
              </Stack.Item>
            )
          )}
          <Stack.Item grow>
            <Section scrollable fill grow title={vote_in_progress ? "Available Events (" + end_time + " seconds) " : "Available Events"}>
              {vote_in_progress ? (
                <LabeledList>
                  {event_list.map(event => (
                    <LabeledList.Item
                      label={event.name}
                      key={event.name}
                      buttons={(
                        <Button
                          color={event.self_vote ? "good" : "blue"}
                          icon="vote-yea"
                          content="Vote"
                          onClick={() => act('register_vote', {
                            event_ref: event.ref,
                          })} />
                      )} />
                  ))}
                </LabeledList>
              ) : (
                <NoticeBox>
                  No vote in progress.
                </NoticeBox>
              )}
            </Section>
          </Stack.Item>
          {!!admin_mode && (
            <Stack.Item>
              <Section scrollable grow fill height="150px" title="Previous Events">
                {previous_events.length > 0 ? (
                  <LabeledList>
                    {previous_events.map(event => (
                      <LabeledList.Item
                        label="Event"
                        key={event}>
                        {event}
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                ) : (
                  <NoticeBox>
                    No previous events.
                  </NoticeBox>
                )}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};
