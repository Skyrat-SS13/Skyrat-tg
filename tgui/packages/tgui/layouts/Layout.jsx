/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { classes } from 'common/react';
import { useEffect, useRef } from 'react';

import { computeBoxClassName, computeBoxProps } from '../components/Box';
import { addScrollableNode, removeScrollableNode } from '../events';

export const Layout = (props) => {
  const { className, theme = 'nanotrasen', children, ...rest } = props;
  return (
    <div className={'theme-' + theme}>
      <div
        className={classes(['Layout', className, computeBoxClassName(rest)])}
        {...computeBoxProps(rest)}
      >
        {children}
      </div>
    </div>
  );
};

const LayoutContent = (props) => {
  const { className, scrollable, children, ...rest } = props;
<<<<<<< HEAD:tgui/packages/tgui/layouts/Layout.jsx
=======
  const node = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const self = node.current;

    if (self && scrollable) {
      addScrollableNode(self);
    }
    return () => {
      if (self && scrollable) {
        removeScrollableNode(self);
      }
    };
  }, []);

>>>>>>> 0611009eb43 (React cleanup (#82607)):tgui/packages/tgui/layouts/Layout.tsx
  return (
    <div
      className={classes([
        'Layout__content',
        scrollable && 'Layout__content--scrollable',
        className,
        computeBoxClassName(rest),
      ])}
      ref={node}
      {...computeBoxProps(rest)}
    >
      {children}
    </div>
  );
};

Layout.Content = LayoutContent;
