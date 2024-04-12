/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { classes } from 'common/react';

import { computeBoxClassName, computeBoxProps } from './Box';

export const Table = (props) => {
  const { className, collapsing, children, ...rest } = props;
  return (
    <table
      className={classes([
        'Table',
        collapsing && 'Table--collapsing',
        className,
        computeBoxClassName(rest),
      ])}
      {...computeBoxProps(rest)}
    >
      <tbody>{children}</tbody>
    </table>
  );
};

export const TableRow = (props) => {
  const { className, header, ...rest } = props;
  return (
    <tr
      className={classes([
        'Table__row',
        header && 'Table__row--header',
        className,
        computeBoxClassName(props),
      ])}
      {...computeBoxProps(rest)}
    />
  );
<<<<<<< HEAD:tgui/packages/tgui/components/Table.jsx
};
=======
}

Table.Row = TableRow;

type CellProps = Partial<{
  /** Collapses table cell to the smallest possible size,
  and stops any text inside from wrapping. */
  collapsing: boolean;
  /** Additional columns for this cell to expand, assuming there is room. */
  colSpan: number;
  /** Whether this is a header cell. */
  header: boolean;
  /** Rows for this cell to expand, assuming there is room. */
  rowSpan: number;
}> &
  BoxProps;

export function TableCell(props: CellProps) {
  const { className, collapsing, colSpan, header, ...rest } = props;
>>>>>>> 01492ce8e5a (Removes grid usage + heavy refactors (#82571)):tgui/packages/tgui/components/Table.tsx

export const TableCell = (props) => {
  const { className, collapsing, header, ...rest } = props;
  return (
    <td
      className={classes([
        'Table__cell',
        collapsing && 'Table__cell--collapsing',
        header && 'Table__cell--header',
        className,
        computeBoxClassName(props),
      ])}
      {...computeBoxProps(rest)}
    />
  );
};

Table.Row = TableRow;
Table.Cell = TableCell;
