// THIS IS A SKYRAT UI FILE
import { useBackend } from '../backend';
import { Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const MicrofusionGunControl = (props) => {
  const { act, data } = useBackend();
  const { current_players, servers = [] } = data;
  return (
    <Window title="Server Control Panel" width={500} height={700}>
      <Window.Content>
        {servers.len === 0 ? (
          <NoticeBox>No server is currently online.</NoticeBox>
        ) : (
          servers.map((server) => (
            <Section
              key={server.name}
              title={server.name}
              buttons={
                <Button
                  icon="connect"
                  content="Connect"
                  onClick={() =>
                    act('connect', {
                      server_ref: server.name,
                    })
                  }
                />
              }
            >
              <LabeledList>
                <LabeledList.Item label="Players">
                  {server.players}/{server.max_players}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          ))
        )}
      </Window.Content>
    </Window>
  );
};
