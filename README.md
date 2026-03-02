# Lustgrow BI Dashboard + Blog Content

Panel de control de negocios y contenido editorial para **Lustgrow Growshop** — tienda especializada en cultivo indoor en Argentina.

## Estructura del proyecto

```
/
├── dashboard/
│   └── index.html          # Panel BI interactivo (HTML standalone)
└── blog/
    ├── plan-contenido-blog.md               # Estrategia editorial + calendario
    ├── articulo-01-guia-cultivo-interior.md
    ├── articulo-02-led-vs-hps-vs-lec.md
    ├── articulo-03-control-plagas-organico.md
    ├── articulo-04-tecnicas-entrenamiento-lst-scrog.md
    ├── articulo-05-nutricion-deficiencias.md
    ├── articulo-06-hidroponia-coco-vs-tierra.md
    └── articulo-07-cosecha-secado-curado.md
```

## Dashboard BI

`dashboard/index.html` — Abrí directo en el navegador (no requiere servidor).

**Secciones:**
- **Resumen:** KPIs consolidados de ambas tiendas, top 10 productos, gráficos de ingresos
- **Tiendanube:** Métricas de lustgrow.com.ar, tráfico por fuente, oportunidades de mejora
- **MercadoLibre:** Ventas, reputación, tipo de publicaciones, acciones recomendadas
- **Blog/Contenido:** Catálogo de artículos listos, calendario editorial, estado de publicación

## Blog — Artículos listos para publicar

| # | Artículo | Nivel | Min lectura |
|---|---------|-------|-------------|
| 1 | Guía Completa Cultivo Indoor Principiantes | Principiante | 8 |
| 2 | LED vs HPS vs LEC: Qué Lámpara Elegir | Intermedio | 6 |
| 3 | Control de Plagas Orgánico | Intermedio | 7 |
| 4 | LST, SCROG y Topping | Avanzado | 9 |
| 5 | Nutrición y Deficiencias | Intermedio | 10 |
| 6 | Hidro, Coco o Tierra: Qué Sustrato Usar | Principiante | 7 |
| 7 | Cosecha, Secado y Curado | Intermedio | 8 |

## Cómo publicar en Tiendanube

1. Entrá al Admin de tu tienda → **Marketing → Blog**
2. Creá una nueva entrada
3. Copiá el contenido del `.md` correspondiente
4. Agregá imágenes relevantes (producto del artículo)
5. Completá el meta-título y meta-descripción con la keyword principal
6. Publicá y compartí en redes sociales

## Próximos pasos

- [ ] Integrar API de Tiendanube para datos reales en el dashboard
- [ ] Integrar API de MercadoLibre (OAuth)
- [ ] Automatizar publicación del blog con scheduled posts
- [ ] Agregar Google Analytics al dashboard
