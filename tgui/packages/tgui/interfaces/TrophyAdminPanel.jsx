import { decodeHtmlEntities } from 'common/string';
import { useBackend } from '../backend';
import { Button, Table } from '../components';
import { Window } from '../layouts';

export const TrophyAdminPanel = (props) => {
  const { act, data } = useBackend();
  const { trophies } = data;
  return (
    <Window title="Trophies Admin Panel" width={800} height={600}>
      <Window.Content scrollable>
        <Table>
          <Table.Row header>
            <Table.Cell color="label">Path</Table.Cell>
            <Table.Cell color="label" />
            <Table.Cell color="label">Message</Table.Cell>
            <Table.Cell color="label" />
            <Table.Cell color="label">Placer Key</Table.Cell>
            <Table.Cell color="label" />
          </Table.Row>
          {!!trophies &&
            trophies.map((trophy) => (
              <Table.Row key={trophy.ref} className="candystripe">
                <Table.Cell
                  style={{
<<<<<<< HEAD
                    'word-break': 'break-all',
                    'word-wrap': 'break-word',
                    'color': !trophy.is_valid
=======
                    wordBreak: 'break-all',
                    wordWrap: 'break-word',
                    color: !trophy.is_valid
>>>>>>> 2631b0b8ef1 (Replaces prettierx with the normal prettier (#80189))
                      ? 'rgba(255, 0, 0, 0.5)'
                      : 'inherit',
                  }}
                >
                  {decodeHtmlEntities(trophy.path)}
                </Table.Cell>
                <Table.Cell>
                  <Button
                    icon="edit"
                    tooltip={'Edit path'}
                    tooltipPosition="bottom"
                    onClick={() => act('edit_path', { ref: trophy.ref })}
                  />
                </Table.Cell>
                <Table.Cell
                  style={{
<<<<<<< HEAD
                    'word-break': 'break-all',
                    'word-wrap': 'break-word',
                  }}>
=======
                    wordBreak: 'break-all',
                    wordWrap: 'break-word',
                  }}
                >
>>>>>>> 2631b0b8ef1 (Replaces prettierx with the normal prettier (#80189))
                  {decodeHtmlEntities(trophy.message)}
                </Table.Cell>
                <Table.Cell>
                  <Button
                    icon="edit"
                    tooltip={'Edit message'}
                    tooltipPosition="bottom"
                    onClick={() => act('edit_message', { ref: trophy.ref })}
                  />
                </Table.Cell>
                <Table.Cell
                  style={{
<<<<<<< HEAD
                    'word-break': 'break-all',
                    'word-wrap': 'break-word',
                  }}>
=======
                    wordBreak: 'break-all',
                    wordWrap: 'break-word',
                  }}
                >
>>>>>>> 2631b0b8ef1 (Replaces prettierx with the normal prettier (#80189))
                  {decodeHtmlEntities(trophy.placer_key)}
                </Table.Cell>
                <Table.Cell>
                  <Button
                    icon="trash"
                    tooltip={'Delete trophy'}
                    tooltipPosition="bottom"
                    onClick={() => act('delete', { ref: trophy.ref })}
                  />
                </Table.Cell>
              </Table.Row>
            ))}
        </Table>
      </Window.Content>
    </Window>
  );
};
