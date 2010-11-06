module Article
require 'date'
module_function

  def gen(root, base)
    date = Date.today.strftime('%Y-%m-%d')
    posts = root + '_posts'
    post = (posts + date).to_s + '-' + base + '.textile'
    if not File.exists?(post)
      File.open(post, File::CREAT|File::TRUNC|File::RDWR, 0644) do |out|
        
        out << '---
layout: post
published: true
date: ' + date + '
tags: [ photo, asso, en_cours]
title: ' + base + '
---

Article en cours de rédaction ...

{% include ' + base + '.html' +' %}

'
      end
    end
    return post
  end
    def today(root, base)
    date = Date.today.strftime('%Y-%m-%d')
    posts = root + '_posts'
    post = (posts + date).to_s + '-' + base + '.textile'
    if not File.exists?(post)
      File.open(post, File::CREAT|File::TRUNC|File::RDWR, 0644) do |out|
        
        out << '---
layout: post
published: true
date: ' + date + '
tags: [ ]
title: Nouvel article
---

Article en cours de rédaction ...

'
      end
    end
    return post
  end
  
end
