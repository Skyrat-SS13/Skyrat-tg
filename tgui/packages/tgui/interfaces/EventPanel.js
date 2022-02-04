import { useBackend, useLocalState } from '../backend';
import { Section, Button, NoticeBox, LabeledList, Stack } from '../components';
import { Window } from '../layouts';

export const EventPanel = (props, context) => {
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const { act, data } = useBackend(context);
  const {
    event_list = [],
    votes = [],
    end_time,
    vote_in_progress,
  } = data;
  return (
    <Window
      title={"Event Panel"}
      width={500}
      height={840}
      theme={"admin"}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section title={vote_in_progress ? "Event Control (" + end_time + " seconds) " : "Event Control"}>
              <Button
                icon="plus"
                content="Start Vote"
                disabled={vote_in_progress}
                onClick={() => act('start_vote')} />
              <Button
                icon="stopwatch"
                content="End Vote"
                disabled={!vote_in_progress}
                onClick={() => act('end_vote')} />
              <Button
                icon="ban"
                content="Cancel Vote"
                disabled={!vote_in_progress}
                onClick={() => act('cancel_vote')} />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="Current Votes">
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
          <Stack.Item grow>
            <Section scrollable fill grow title="Available Events">
              {vote_in_progress ? (
                <LabeledList>
                  {event_list.map(event => (
                    <LabeledList.Item
                      label={event.name}
                      key={event.name}
                      buttons={(
                        <Button
                          disabled={vote_registered}
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
        </Stack>
      </Window.Content>
    </Window>
  );
};
