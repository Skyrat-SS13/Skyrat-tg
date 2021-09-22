/**
 * @file
 * @copyright 2021 Aleksej Komarov
 * @license MIT
 */

import { classes } from 'common/react';
<<<<<<< HEAD
import { computeBoxClassName, computeBoxProps } from './Box';
=======
import { RefObject } from 'inferno';
>>>>>>> b1edd353b7a (tgui: Remove Flex IE fixes, Fix IE8 button clicks (#61496))
import { computeFlexClassName, computeFlexItemClassName, computeFlexItemProps, computeFlexProps, FlexItemProps, FlexProps } from './Flex';

type StackProps = FlexProps & {
  vertical?: boolean;
  fill?: boolean;
};

export const Stack = (props: StackProps) => {
  const { className, vertical, fill, ...rest } = props;
  return (
    <div
      className={classes([
        'Stack',
        fill && 'Stack--fill',
        vertical
          ? 'Stack--vertical'
          : 'Stack--horizontal',
        className,
        computeFlexClassName(props),
      ])}
      {...computeFlexProps({
        direction: vertical ? 'column' : 'row',
        ...rest,
      })}
    />
  );
};

const StackItem = (props: FlexProps) => {
  const { className, ...rest } = props;
  return (
    <div
      className={classes([
        'Stack__item',
        className,
        computeFlexItemClassName(rest),
      ])}
<<<<<<< HEAD
      {...computeBoxProps(computeFlexItemProps(rest))}
=======
      ref={innerRef}
      {...computeFlexItemProps(rest)}
>>>>>>> b1edd353b7a (tgui: Remove Flex IE fixes, Fix IE8 button clicks (#61496))
    />
  );
};

Stack.Item = StackItem;

type StackDividerProps = FlexItemProps & {
  hidden?: boolean;
};

const StackDivider = (props: StackDividerProps) => {
  const { className, hidden, ...rest } = props;
  return (
    <div
      className={classes([
        'Stack__item',
        'Stack__divider',
        hidden && 'Stack__divider--hidden',
        className,
        computeFlexItemClassName(rest),
      ])}
      {...computeFlexItemProps(rest)}
    />
  );
};

Stack.Divider = StackDivider;
