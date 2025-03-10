from django import template

register = template.Library()

@register.filter
def get_item(dictionary, key):
    """获取字典中的值，用于在模板中访问嵌套字典"""
    if isinstance(dictionary, dict):
        return dictionary.get(str(key))
    return None 