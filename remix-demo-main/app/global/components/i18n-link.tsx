import { Link, LinkProps } from '@remix-run/react';
import { forwardRef } from 'react';
import { useTranslation } from 'react-i18next';

//

export const I18nLink = forwardRef<HTMLAnchorElement, LinkProps>((props, ref) => {
  const { i18n } = useTranslation();

  return <Link ref={ref} {...props} to={parseI18nNavigate(props.to, i18n.language)} />;
});

I18nLink.displayName = 'I18nLink';

//

const parseI18nNavigate = (to: LinkProps['to'], lang: string) => {
  if (typeof to === 'string' && /^\./.test(to)) return to;
  if (typeof to === 'string') return '/' + lang + '/' + String(to).replace(/^\//, '');
  if (typeof to === 'object' && to.pathname)
    return { ...to, pathname: '/' + lang + '/' + String(to.pathname).replace(/^\//, '') };

  return to;
};
