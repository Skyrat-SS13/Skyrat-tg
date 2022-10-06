import { useBackend } from '../backend';
import { Table, TableCell, TableRow } from '../components/Table';
import { Window } from '../layouts';

export type PassportData = {
  name: string;
  tgui_style: string;
  headshot_data: string;
  empire: string;
  locale: string;
  age: string;
};

export const EmpireEntry = (props, context) => {
  let contents;
  const { data } = useBackend<PassportData>(context);
  if (data.empire) {
    contents = <p>{data.empire}</p>;
  } else {
    contents = <p>Independent Citizen</p>;
  }
  return contents;
};

export const LocaleEntry = (props, context) => {
  let contents;
  const { data } = useBackend<PassportData>(context);
  if (data.empire) {
    contents = <p>{data.locale}</p>;
  } else {
    contents = <p>Unknown</p>;
  }
  return contents;
};

export const Passport = (props, context) => {
  const { data } = useBackend<PassportData>(context);
  return (
    <Window theme={data.tgui_style}>
      <Window.Content
        style={data.tgui_style === 'ntos' ? {} : { 'color': '#000000' }}>
        <p style={{ 'text-align': 'center' }}>
          <img
            src={'data:image/png;base64,' + data.headshot_data}
            height={128}
            width={128}
            style={{
              '-ms-interpolation-mode': 'nearest-neighbor',
              'background-color': 'black',
            }}
          />
        </p>
        <Table>
          <TableRow>
            <TableCell>
              <b>Name:</b>
            </TableCell>
            <TableCell>{data.name}</TableCell>
          </TableRow>
          <TableRow>
            <TableCell>
              <b>Citizenship:</b>
            </TableCell>
            <TableCell>
              <EmpireEntry />
            </TableCell>
          </TableRow>
          <TableRow>
            <TableCell>
              <b>Locale of Origin:</b>
            </TableCell>
            <TableCell>
              <LocaleEntry />
            </TableCell>
          </TableRow>
          <TableRow>
            <TableCell>
              <b>Age:</b>
            </TableCell>
            <TableCell>{data.age}</TableCell>
          </TableRow>
        </Table>
      </Window.Content>
    </Window>
  );
};
