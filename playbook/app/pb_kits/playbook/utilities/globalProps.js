// Prop categories
const spacingProps = ({
  marginRight,
  marginLeft,
  marginTop,
  marginBottom,
  marginX,
  marginY,
  margin,
  paddingRight,
  paddingLeft,
  paddingTop,
  paddingBottom,
  paddingX,
  paddingY,
  padding,
}) => {
  let css = ''
  css += marginRight ? `mr_${marginRight} ` : ''
  css += marginLeft ? `ml_${marginLeft} ` : ''
  css += marginTop ? `mt_${marginTop} ` : ''
  css += marginBottom ? `mb_${marginBottom} ` : ''
  css += marginX ? `mx_${marginX} ` : ''
  css += marginY ? `my_${marginY} ` : ''
  css += margin ? `m_${margin} ` : ''
  css += paddingRight ? `pr_${paddingRight} ` : ''
  css += paddingLeft ? `pl_${paddingLeft} ` : ''
  css += paddingTop ? `pt_${paddingTop} ` : ''
  css += paddingBottom ? `pb_${paddingBottom} ` : ''
  css += paddingX ? `px_${paddingX} ` : ''
  css += paddingY ? `py_${paddingY} ` : ''
  css += padding ? `p_${padding} ` : ''
  return css
}

const darkProps = ({ dark }) => {
  let css = ''
  css += dark ? 'dark' : ''
  return css
}

// All Exported as a single function
export const globalProps = (props, defaultProps = {}) => {
  const allProps = { ...props, ...defaultProps }
  return spacingProps(allProps) + darkProps(allProps)
}

export const deprecatedProps = (kit, props = {}) => {
  if (process.env.NODE_ENV === 'development') {
    /* eslint no-console: ["error", { allow: ["warn", "error"] }] */
    props.forEach((propName) => console.warn(`${kit} Kit: The prop '${propName}' is deprecated and will be removed a future release!`))
  }
}